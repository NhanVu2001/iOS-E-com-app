import SwiftUI
import SDWebImageSwiftUI


let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height
struct ItemLoneView: View {
    @Binding var item: Item
    @Binding var currentView: String
    
    var body: some View {
        VStack (alignment: .leading){
            Spacer()
            
            Button(action: {currentView = "Home"}) {
                
                Image(systemName: "chevron.left")
                    .font(.system(size: 26, weight: .heavy))
                    .foregroundColor(Color("pink"))
                Text("Back")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            
            .padding()
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .frame(width: UIScreen.main.bounds.width,height: 250)
            HStack{
                Text(item.item_name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink)
                ForEach(1...5,id: \.self){index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_ratings) ?? 0 ? Color(.yellow) : .gray)
                    
                }
            }.offset(x:15)
            Divider()
            HStack(){
                Text("Price: ").fontWeight(.heavy)
                Text("\(item.item_cost.stringValue)$")
                
                Spacer()
                
            }.offset(x:15)
            Divider()
            ScrollView(.vertical){
                Text("Item description")
                    .fontWeight(.heavy)
                    .frame(width: width, alignment: .topLeading)
                Text(item.item_details)
                    .frame(width: width, alignment: .topLeading)
            }.frame(width: width, height: height * 0.5
                    , alignment: .topLeading)
            .offset(x: 15)
            
            Spacer()
            
        }
        
    }
}
