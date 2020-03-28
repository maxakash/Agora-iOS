import SwiftUI

@available(iOS 13, *)
public struct DatePick: View {
    @State private var dateSelected = Date()
    @Binding var enableDatePicker: Bool
    @Binding var selectedDatePicker: Bool
    @Binding var date: String
    
    
    public init(enableDatePicker: Binding<Bool>,selectedDatePicker:Binding<Bool>,  date: Binding<String> ) {
        self._enableDatePicker = enableDatePicker
        self._selectedDatePicker = selectedDatePicker
        self._date = date
        
    }
  
    public var body: some View {
        return  GeometryReader { gr in
            VStack {
                VStack {
                    Text("Select Date")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                        .padding(.top, 15)
                    
                    Group {
                        DatePicker("a",selection: self.$dateSelected).labelsHidden()
                    }
                }.background(RoundedRectangle(cornerRadius: 10)
                 .foregroundColor(Color("datePickerColor"))
                 .shadow(radius: 1)).padding()
                
                VStack {
                     Button(action: {
                        self.date =  self.dateSelected.asString()
                        self.enableDatePicker = false
                        self.selectedDatePicker = false
                        
                    }) {
                      Text("Done")
                        .font(Font.custom("poppins", size: 25))
                        .foregroundColor(Color("buttonColor"))
                        .frame(height: 57)
                        .frame(minWidth: 0, maxWidth: .infinity,alignment: .center)
                        .padding(.horizontal,80)
                        .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("datePickerColor")).shadow(radius: 1))
                        
                    }.padding()
    
                }
            }.position(x: gr.size.width / 2 ,y: gr.size.height - 225)
        }
    }
    
    
    
    
}

extension Date {
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
}


