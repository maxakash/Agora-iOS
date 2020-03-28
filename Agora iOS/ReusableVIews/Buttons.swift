//
//  Buttons.swift
//  Agora iOS
//
//  Created by Akash Chaudhary on 22/03/20.
//  Copyright © 2020 Akash Chaudhary. All rights reserved.
//

import SwiftUI

struct Buttons: View {
    
    var label: String
    var icon: String
    var backgroundColor: String
    
    var body: some View {

        HStack{
             
            Text(self.label)
                .font(.system(size: 25))
                .minimumScaleFactor(0.8)
                .foregroundColor(Color.white)
                .frame(height: 55)
                .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
 
            Image(systemName: self.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20, alignment: .trailing)
                .foregroundColor(Color.white)
                .padding(.vertical,10)
                .padding(.horizontal,20)
            
            
        }
        .background(Color(self.backgroundColor))
        .cornerRadius(8)
  
    }
}

