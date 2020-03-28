//
//  ContentView.swift
//  Agora iOS
//
//  Created by Akash Chaudhary on 22/03/20.
//  Copyright © 2020 Akash Chaudhary. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //variable to keep track of the selected item in the TabView
    @State var index  = 0
    
    var body: some View {
        VStack {
            
            if self.index == 0 {
                //Display Home view on selecting first item from the TabView
                Home(index: $index)
            } else if self.index == 1 {
                //Display Home view on selecting second item from the TabView
                Home(index: $index)
            } else if self.index == 2 {
                //Display Home view on selecting third item from the TabView
                Home(index: $index)
            } else if self.index == 3 {
                //Display Home view on selecting fourth item from the TabView
                Home(index: $index)
            }
      
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}









