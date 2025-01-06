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

struct Menu: View {
    @Binding var homeData : HomeViewModel
    @Binding var currentView: String
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: CartView(homeData: homeData, currentView: $currentView)) {
                
                HStack(spacing: 15){
                    
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(Color("pink"))
                    
                    Text("Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .onTapGesture {
                currentView = "cart"
            }
            NavigationLink(destination: loginContentView(currentView: $currentView)){
                
                HStack(spacing: 15){
                    
                    Image(systemName: "arrowshape.turn.up.backward.2")
                        .font(.title)
                        .foregroundColor(Color("pink"))
                    
                    Text("Sign out")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .onTapGesture {
                do {
                    try Auth.auth().signOut()
                    currentView = "signIn"
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }
            
            Spacer()
            
            HStack{
                
                Spacer()
                
                Text("Version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(Color("pink"))
            }
            .padding(10)
        }
        .padding([.top,.trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
    }
}

