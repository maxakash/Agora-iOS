//
//  createElection.swift
//  Agora iOS
//
//  Created by Akash Chaudhary on 24/03/20.
//  Copyright © 2020 Akash Chaudhary. All rights reserved.
//

import SwiftUI


struct ElectionDetail: View {
    //variables required for creating elections
    @State private var  electionName = ""
    @State private var electionDescription = ""
    @State private var startDate = ""
    @State private var endDate = ""
    //variable required to open date picker
    @State var enableStartDate = false
    @State var enableEndDate = false
    @State var enableDatePicker = false
    //variable which controls the color of textfield
    @State var electionNameColor = "textFieldBorderColor"
    @State var descriptionColor = "textFieldBorderColor"
    @State var startDateColor = "textFieldBorderColor"
    @State var endDateColor = "textFieldBorderColor"
    //controls navigation to add candidates view
    @State var navigate:Bool = false
    //required to move to root view after election is created.
    @Binding var rootIsActive : Bool
        
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color("buttonColor"))
                .frame(width: geometry.size.width/3, height: 3,alignment: .top)
            
            
            ZStack(alignment:.top){
                VStack(alignment:.leading){
                    
                    FloatingLabelTextField(placeHolder: "Election Name", text: self.$electionName, color: self.$electionNameColor)
                    FloatingLabelTextField(placeHolder: "Election Description", text: self.$electionDescription, color: self.$descriptionColor)
                    
                    Button(action: {
                        self.enableStartDate = true
                        self.enableDatePicker = true
                    }) {
                        FloatingLabelTextField(placeHolder: "Start Date", text: self.$startDate, color: self.$startDateColor)
                    }
                    Button(action: {
                        self.enableEndDate = true
                        self.enableDatePicker = true
                    }) {
                        FloatingLabelTextField(placeHolder: "End Date", text: self.$endDate,color: self.$endDateColor)
                    }

                    Spacer()
                    
                    //Checking whether all details have been entered or not
                    
                    NavigationLink(destination:AddCandidates(electionName: self.$electionName, rootIsActive: self.$rootIsActive),isActive: self.$navigate) {
                        
                        Buttons(label: "Add Candidates", icon:"arrow.right" , backgroundColor: "buttonColor").onTapGesture(perform: {
                            
                            
                            if(self.electionName == ""){
                                self.electionNameColor = "redColor"
                            }
                            if(self.electionDescription == ""){
                                self.descriptionColor = "redColor"
                            }
                            if(self.startDate == ""){
                                self.startDateColor = "redColor"
                            }
                            if(self.endDate == ""){
                                self.endDateColor = "redColor"
                            }
                            if(self.electionName != "" && self.electionDescription != "" &&  self.startDate != "" && self.endDate != ""){
                                self.saveDataToDatabase()
                                self.navigate = true                        }
                            
                        })
                          .frame(minWidth: 0, maxWidth: .infinity,alignment: .bottom)
                        
                    }.isDetailLink(false)
                }
                    
                .padding()
                .blur(radius: self.$enableDatePicker.wrappedValue ? 1 : 0 )
                .overlay(
                    self.$enableDatePicker.wrappedValue ? Color.black.opacity(0.4) : nil
                )
                    .frame(minHeight: 0,maxHeight: .infinity)
            }
            
            //Start Date picker is opened when Start Date is tapped
            if self.$enableStartDate.wrappedValue {
                DatePick(enableDatePicker: self.$enableDatePicker,selectedDatePicker:self.$enableStartDate, date: self.$startDate)
            }
            
            //End Date picker is opened when Start Date is tapped
            
            if self.$enableEndDate.wrappedValue {
                
                DatePick(enableDatePicker: self.$enableDatePicker,selectedDatePicker:self.$enableEndDate, date: self.$endDate)
                
            }
            
            Spacer()
            
        }
        .navigationBarTitle("Election Details",displayMode: .automatic)
        .background(Color("backgroundColor"))
        
        
        
    }
}



struct ElectionDetail_Previews: PreviewProvider {
    static var previews: some View {
        ElectionDetail(rootIsActive: .constant(false))
    }
}


//MARK: - Saving data to database

extension ElectionDetail{
    func saveDataToDatabase(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let electionDetails = Election(context: context)
        electionDetails.electionName = electionName
        electionDetails.electionDescription = electionDescription
        electionDetails.electionStartDate = startDate
        electionDetails.electionEndDate = endDate
        electionDetails.electionCandidates = ""
        electionDetails.electionVotingMethod = ""
        
        do {
            try context.save()
        } catch {
            print(error)
        }
  
    }
}


















