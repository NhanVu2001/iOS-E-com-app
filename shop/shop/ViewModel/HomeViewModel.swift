import SwiftUI
import CoreLocation
import Firebase

// Fetching User Location....
class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    // Location Details....
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    // Menu...
    @Published var showMenu = false
    
    // ItemData...
    
    @Published var items: [Item] = []
    @Published var filtered: [Item] = []
    
    // Cart Data...
    
    @Published var cartItems : [Cart] = []
    @Published var ordered = false
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // checking Location Access....
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            // Direct Call
            locationManager.requestWhenInUseAuthorization()
            // Modifying Info.plist...
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // reading User Location And Extracting Details....
        
        self.userLocation = locations.last
        self.extractLocation()
        // after Extracting Location Logging In....
        self.fetchData()
    }
    
    func extractLocation(){
        //        let db = Firestore.firestore()
        //        db.collection("Users").document(Auth.auth().currentUser!.email!).getDocument(as: ){ (document, error) in
        //            if let document = document{
        //                let geodata = document.data().map(String.init(location:)) ?? "nil"
        //                print(geodata)
        //            }
        //        }
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else{return}
            
            var address = ""
            
            // getting area and locatlity name....
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    
    
    // Fetching Items Data....
    
    func fetchData(){
        
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments { (snap, err) in
            
            guard let itemData = snap else{return}
            
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let ratings = doc.get("item_ratings") as! String
                let image = doc.get("item_image") as! String
                let details = doc.get("item_details") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_ratings: ratings)
            })
            
            self.filtered = self.items
        }
    }
    
    // Search or Filter...
    
    func filterData(){
        
        withAnimation(.linear){
            
            self.filtered = self.items.filter{
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
    // add to Cart Function....
    
    func addToCart(item: Item){
        
        // checking it is added...
        
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        // updating filtered array also for search bar results...
        
        let filterIndex = self.filtered.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        
        self.filtered[filterIndex].isAdded = !item.isAdded
        
        if item.isAdded{
            
            // removing from list...
            
            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
            return
        }
        // else adding...
        
        self.cartItems.append(Cart(item: item, quantity: 1))
        
        
    }
    
    func getIndex(item: Item,isCartIndex: Bool)->Int{
        
        let index = self.items.firstIndex { (item1) -> Bool in
            
            return item.id == item1.id
        } ?? 0
        
        let cartIndex = self.cartItems.firstIndex { (item1) -> Bool in
            
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    
    
    func calculateTotalPrice()->String{
        
        var price : Float = 0
        
        cartItems.forEach { (item) in
            price += Float(item.quantity) * Float(truncating: item.item.item_cost)
        }
        
        return getPrice(value: price)
    }
    
    func getPrice(value: Float)->String{
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    // writing Order Data into FIrestore...
    
    func updateOrder(){
        
        let db = Firestore.firestore()
        
        // creating dict of food details...
        
        if ordered{
            
            ordered = false
            
            db.collection("Users").document(Auth.auth().currentUser!.email!).delete { (err) in
                
                if err != nil{
                    self.ordered = true
                }
            }
            
            return
        }
        
        var details : [[String: Any]] = []
        
        cartItems.forEach { (cart) in
            
            details.append([
                
                "item_name": cart.item.item_name,
                "item_quantity": cart.quantity,
                "item_cost": cart.item.item_cost
            ])
        }
        
        ordered = true
        
        db.collection("Users").document(Auth.auth().currentUser!.email!).setData([
            
            "ordered_food": details,
            "total_cost": calculateTotalPrice()
            
        ]) { (err) in
            
            if err != nil{
                self.ordered = false
                return
            }
            print("success")
        }
    }
}
