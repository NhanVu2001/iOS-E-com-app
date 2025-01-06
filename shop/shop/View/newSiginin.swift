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
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
let storedUsername = "Admin"
let storedPassword = "Admin"

struct loginContentView: View {
    @State private var error = ""
    @State  private var email = ""
    @State private var password = ""
    
    @State var wrongLoginInput: Bool = false
    @State var correctLoginInput: Bool = false
    @State  private var userIsLoggedIn = false
    
    
    @Binding var currentView: String
    
    
    @StateObject var HomeModel = HomeViewModel()
 
    
    
    
    
    var body: some View {
        
        
        VStack{
            WelcomeText()
            
            getUserNameField(userName: $email)
            getPasswordField(passWord: $password)
            if(!error.isEmpty){
                Text(error).foregroundColor(.red).frame(width: 350,height: 100, alignment: .topLeading)
            }
            Button(action: {
                login()
            }){
                
                LoginButtonText()
                
                
            }
            // SignUp button
            Button(action: {
                currentView = "signUp"
            }){
                SignUpButtonText()
            }
        }
        
        .padding()
    }
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){result, e in
            if e != nil{
                print(e!.localizedDescription)
                error = e!.localizedDescription
                return
            }
            currentView = "Home"
        }
        
    }
    
    
    
}



struct loginContentView_Previews: PreviewProvider {
    static var previews: some View {
        loginContentView(currentView: .constant("login"))
    }
}


// setup for login page

struct WelcomeText : View{
    var body: some View{
        ZStack {
            VStack{
                Image("shop").aspectRatio(contentMode: .fit).padding(.horizontal)
                
                Text("22Shop")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
            }
        }
        
        
    }
}



struct getUserNameField : View {
    @Binding var userName : String
    var body: some View{
        TextField("Username" , text:  $userName)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5)
            .autocapitalization(.none)
            .padding(.bottom, 20)
    }
}

struct getPasswordField : View{
    @Binding var passWord : String
    var body: some View{
        SecureField("Password", text: $passWord)
            .padding()
            .background(lightGreyColor)
            .autocapitalization(.none)
            .cornerRadius(5)
            .padding(.bottom, 20)
    }
}

struct LoginButtonText : View{
    var body: some View{
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.pink)
            .cornerRadius(15.0)
    }
}

struct SignUpButtonText : View{
    var body: some View{
        return Text("SIGNUP")
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.pink)
            .cornerRadius(15.0)
    }
}
