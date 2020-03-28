//
//  createElection.swift
//  Agora iOS
//
//  Created by Akash Chaudhary on 24/03/20.
//  Copyright © 2020 Akash Chaudhary. All rights reserved.
//

import SwiftUI
import CoreData

struct VotingAlgorithm: View {
    //voting methods
    let methods = ["Oklahoma", "RangeVoting", "RankedPairs", "Satisfaction Approval Voting","Sequential Proportional Approval voting","SmithSet","Approval","Exhaustive ballot","Baldwin","Uncovered Set","Copeland","Oklahoma "]
    
    //variable storing selected voting method
    @State private var selectedMethod: String = ""
    //binding election name to makesure one value is selected from the list
    @Binding var electionName: String
    @Binding var rootIsActive : Bool
    @State var showError:Bool = false


    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color("buttonColor"))
                .frame(width: (geometry.size.width), height: 3,alignment: .top)
            
            
            ZStack(alignment:.top){
                
                VStack(alignment:.leading){
                List (self.methods, id: \.self) { votingMethod in
                        MethodRow(method: votingMethod, selectedMethod: self.$selectedMethod)
                    } .listStyle(GroupedListStyle())
                      .environment(\.horizontalSizeClass, .regular)
                      .padding(EdgeInsets(top: -15, leading:-10, bottom: 20
                            , trailing: -10))
                    //toast showing error is no method is selected
                      .toast(isShowing: self.$showError, text: "Please select a voting method")
                    
                    
                    Buttons(label: "Finish", icon:"checkmark" , backgroundColor: "buttonColor")
                        .onTapGesture(perform: {
                            if(self.selectedMethod == ""){
                                self.showError = true
                            }
                            else{
                                self.saveDataToDatabase()
                                self.rootIsActive = false
                            }
                        })
                        .frame(minWidth: 0, maxWidth: .infinity,alignment: .bottom)
                }
                 .padding()
            }
            Spacer()
        }
        .navigationBarTitle("Voting Algorithms",displayMode: .automatic)
        .background(Color("backgroundColor"))
    }
    
}




struct VotingAlgorithm_Previews: PreviewProvider {
    static var previews: some View {
        VotingAlgorithm(electionName: .constant(""), rootIsActive: .constant(false))
    }
}

//MARK: - Functions of the current view


extension VotingAlgorithm{
    
    func saveDataToDatabase(){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Election")
            fetchRequest.predicate = NSPredicate(format: "electionName = %@", String(electionName))
            do{
                
                if let fetchResults = try context.fetch(fetchRequest) as? [NSManagedObject] {
                    if fetchResults.count != 0{
                        
                        let managedObject = fetchResults[0]
                       managedObject.setValue(self.selectedMethod, forKey: "electionVotingMethod")
                        
                        try context.save()
                    }
                }
            }catch{
                print(Error.self)
            }
              
            do {
                try context.save()
            } catch {
                print(error)
            }
      
            
        }
}

//MARK: - Custom row view for the List displaying different voting methods

struct MethodRow: View {
    let method: String
    @Binding var selectedMethod: String
  
    var body: some View {
        HStack() {
            if method == selectedMethod{
                Image(systemName: "checkmark.circle.fill" )
                    .resizable()
                    .frame(width:25, height:25)
                    .foregroundColor(Color("buttonColor"))
            }
            else{
                Image(systemName: "circle" )
                    .resizable()
                    .frame(width:25, height:25)
                    .foregroundColor(Color("buttonColor"))
                
            }
            Text(method)
                .font(.system(size: 20))
                .frame(height: 50,alignment: .leading)
                .padding(.leading,15)
                .foregroundColor(Color("textColor"))
            
        }.onTapGesture {
            self.selectedMethod = self.method
        }
            
        .background(Color.clear)
    }
}






