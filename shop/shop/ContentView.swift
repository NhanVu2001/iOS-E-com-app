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
