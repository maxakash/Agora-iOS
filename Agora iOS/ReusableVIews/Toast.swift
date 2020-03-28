//
//  Toast.swift
//  Agora iOS
//
//  Created by Akash Chaudhary on 28/03/20.
//  Copyright © 2020 Akash Chaudhary. All rights reserved.
//

import SwiftUI

struct Toast<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    let presenting: () -> Presenting
    let text: String

    var body: some View {

        GeometryReader { geometry in

            ZStack(alignment: .center) {

                self.presenting()
                    .blur(radius: self.isShowing ? 1 : 0)

                VStack {
                    Text(self.text)
                     .foregroundColor(Color("textColor"))
                     .padding()
                }
                
                .background(Color("datePickerColor"))
                .cornerRadius(20)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
                .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                          withAnimation {
                            self.isShowing = false
                          }
                        }
                    }
                

            }

        }

    }

}

//adding support to View for easier use
extension View {

    func toast(isShowing: Binding<Bool>, text: String) -> some View {
        Toast(isShowing: isShowing,
              presenting: { self },
              text: text)
    }

}
