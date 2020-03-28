//
//  TabView.swift
//  Agora iOS
//
//  Created by Akash Chaudhary on 26/03/20.
//  Copyright © 2020 Akash Chaudhary. All rights reserved.
//

import SwiftUI

struct TabView: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack(spacing: 15) {
            HStack {
                Image("home")
                    .resizable()
                    .frame(width: 22,height:22)
                Text(self.index == 0 ? "Home" : "")
                    .font(.system(size: 14))
                    .foregroundColor(Color("textColor"))
            }.padding(10)
             .background(self.index == 0 ? Color.green.opacity(0.5) : Color.clear)
             .clipShape(Capsule()).onTapGesture {
                    self.index = 0
            }
            
            HStack {
                Image("elections")
                    .resizable()
                    .frame(width: 25,height:25)
                Text(self.index == 1 ? "Elections" : "")
                    .font(.system(size: 14))
                    .foregroundColor(Color("textColor"))
            }.padding(10)
             .background(self.index == 1 ? Color.green.opacity(0.5) : Color.clear)
             .clipShape(Capsule()).onTapGesture {
                    self.index = 1
            }
            
            HStack {
                Image("profile")
                    .resizable()
                    .frame(width: 25,height:25)
                Text(self.index == 2 ? "Profile" : "")
                    .font(.system(size: 14))
                    .foregroundColor(Color("textColor"))
            }.padding(10)
             .background(self.index == 2 ? Color.green.opacity(0.5) : Color.clear)
             .clipShape(Capsule()).onTapGesture {
                    self.index = 2
            }
            
            HStack {
                Image("contact")
                    .resizable()
                    .frame(width: 25,height:25)
                Text(self.index == 3 ? "Contact" : "")
                    .font(.system(size: 14))
                    .foregroundColor(Color("textColor"))
                
            }.padding(10)
             .background(self.index == 3 ? Color.green.opacity(0.5) : Color.clear)
             .clipShape(Capsule()).onTapGesture {
                    self.index = 3
            }
        }.padding(.top, 10)
         .frame(width: UIScreen.main.bounds.width)
         .background(Color("tabViewColor"))
         .animation(.default)
    }
    
}

