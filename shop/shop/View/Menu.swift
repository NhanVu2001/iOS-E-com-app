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

