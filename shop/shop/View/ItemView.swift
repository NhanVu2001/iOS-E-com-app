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

struct ItemView: View {
    var item: Item
    var body: some View {
        
        VStack{
            
            // Downloading Image From WEb...
            
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 30,height: 250)
            
            HStack(spacing: 8){
                
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                // Ratings View....
                
                ForEach(1...5,id: \.self){index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_ratings) ?? 0 ? Color(.yellow) : .gray)
                }
            }
            
            HStack{
                
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
        }
    }
}

