import SwiftUI

@available(iOS 13, *)
public struct FloatingLabelTextField: View {
    
    @State private var placeHolder: String = ""
    @State private var placeHolderLabel: String = ""
    private var placeHolderValue: String = ""
    @Binding var text: String
    @Binding var color: String
    
    
    public init(placeHolder: String = "",
             text: Binding<String> = .constant(""),
             color: Binding<String> = .constant("") ) {
        
        self._text = text
        self.placeHolderValue = placeHolder
        self._color = color
        
    }
    
    
    
    public var body: some View {
        return ZStack(alignment: .leading) {
            TextField(placeHolder, text: $text, onEditingChanged: { (edit) in
                self.color = "buttonColor"
                self.placeHolderLabel = self.placeHolder
                
                
            })
             .font(.system(size: 20))
             .padding()
             .frame(height: 55)
             .overlay( RoundedRectangle(cornerRadius: 8)
                .stroke(Color(color), lineWidth: 0.6)
                    .frame(height: 55))
             .foregroundColor(Color("textColor"))
             .accentColor(.gray)
             .onAppear {
                 self.placeHolder = self.placeHolderValue
                    }
            
            if color != "redColor"{
                
            Text(placeHolderLabel)
              .font(.system(size: 15))
              .foregroundColor(Color(color))
              .animation(.interactiveSpring())
              .background(Color("backgroundColor"))
              .padding(EdgeInsets(top: 0, leading:10, bottom: 55
                        , trailing: 0))
                
            }
                
            else{
             Text("\(placeHolder)")
               .font(.system(size: 15))
               .foregroundColor(Color(color))
               .animation(.interactiveSpring())
               .background(Color("backgroundColor"))
               .padding(EdgeInsets(top: 0, leading:10, bottom: 55
                        , trailing: 0))
            }
            
            if color == "redColor"{
             Text("Please enter \(placeHolder)")
                .font(.system(size: 15))
                .foregroundColor(Color.red)
                .animation(.interactiveSpring())
                .padding(EdgeInsets(top: 78, leading:10, bottom: 0
                        , trailing: 0))
                
            }
            
        }
        
        
    }
    
}


