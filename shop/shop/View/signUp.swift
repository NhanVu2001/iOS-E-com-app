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

import Firebase
import SwiftUI
import CoreLocation

struct signUp: View {
    @State  private var email = ""
    @State private var password = ""
    @State private var error = ""
    @State private var address = ""
    @State  private var userIsLoggedIn = false
    @Binding var currentView: String
    
    var body: some View{
        VStack{
            WelcomeText()
            
            getUserNameField(userName: $email)
            getPasswordField(passWord: $password)
            
            
            getLocationField(address: $address)
            
            
            
            
            if(!error.isEmpty){
                Text(error).foregroundColor(.red)
            }
            Button{
                register()
            }label: {
                SignUpButtonText()
            }
            
            Button{
                loginView()
            }label: {
                Text("Aldready have an account? Login")
                    .bold()
            }
            .padding(.top)
        }
    }
    
    
    func loginView(){
        currentView = "signIn"
    }
    func register(){
        
        if(address == ""){
            error = "Location field must be filled"
            return
        }
        
        
        getLocation(from: address){location in
            if(location == nil){
                error = "Location not found"
                return
            }
            Auth.auth().createUser(withEmail: email, password: password){result , e in
                if e != nil{
                    error = e!.localizedDescription
                } else{
                    Auth.auth().signIn(withEmail: email, password: password)
                    createUser(location: location)
                    currentView = "Home"
                    
                }
            }
            
            
        }
        
        
    }
    
    func getLocation(from address: String, completion: @escaping(_ location: CLLocationCoordinate2D?)->Void){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address){ (placemarks, error) in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location?.coordinate else{
                completion(nil)
                return
            }
            completion(location)
        }
        
    }
    
    func createUser(location: CLLocationCoordinate2D?){
        let db = Firestore.firestore()
        db.collection("Users").document(Auth.auth().currentUser!.email!).setData([
            "location": GeoPoint(latitude: location!.latitude, longitude: location!.longitude)
            
        ])
        
    }
}

struct getLocationField : View {
    @Binding var address : String
    var body: some View{
        TextField("Location" , text:  $address)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5)
            .autocapitalization(.none)
            .padding(.bottom, 20)
    }
}
