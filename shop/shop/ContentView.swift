import SwiftUI
import Firebase


struct ContentView: View {
    
    
    @State var currentView = "signIn"
    
    @State var HomeModel = HomeViewModel()
    
    @State var item = Item(id:"", item_name: "", item_cost: 0, item_details: "", item_image: "", item_ratings: "")
    
    var body: some View {
        switch(currentView){
        case "signUp":
            signUp(currentView: $currentView)
            
            
        case "signIn":
            loginContentView(currentView: $currentView)
            
            
        case "Home":
            Home(currentView: $currentView, homeData: $HomeModel, itemViewInfo: $item)
            
            
        case "cart":
            CartView(homeData: HomeModel, currentView: $currentView)
            
            
        case "item":
            ItemLoneView(item: $item, currentView: $currentView)
            
            
        default:
            Text("false")
        }
        
    }
}
