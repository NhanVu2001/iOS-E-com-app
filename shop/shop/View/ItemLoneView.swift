/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Group 22
 Dao Minh Cuong: s3866133
 Nguyen Cong Phuong: s3804846
 Vu Thien Nhan: s3810151
 Tran Truong Son: s3818468
 Created  date: dd/mm/yyyy (e.g. 31/07/2022)
 Last modified: dd/mm/yyyy (e.g. 05/08/2022)
 Acknowledgement: https://www.youtube.com/watch?v=bRnBPJ_dzpg&list=PLimqJDzPI-H819xpEm_sc3kOcHLq9FtvF
 https://firebase.google.com/docs/firestore/solutions/geoqueries
 */

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
