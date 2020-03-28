//
//  createElection.swift
//  Agora iOS
//
//  Created by Akash Chaudhary on 24/03/20.
//  Copyright © 2020 Akash Chaudhary. All rights reserved.
//

import SwiftUI
import CoreData

struct AddCandidates: View {
    
    //variable to store candidates name
    @State private var  candidateName = ""
    //variable to control color of text field
    @State var candidateNameColor = "textFieldBorderColor"
    //array storing name of candidates
    @State private var candidateList:[String] = []
    @State var navigate:Bool = false
    @State var showError:Bool = false
    @Binding var electionName: String
    @Binding var rootIsActive : Bool
   
    
    
    public init(electionName: Binding<String> = .constant(""),rootIsActive: Binding<Bool> = .constant(false)){
        self._electionName = electionName
        self._rootIsActive = rootIsActive
        UITableView.appearance().backgroundColor = .clear
 
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color("buttonColor"))
                .frame(width: (geometry.size.width*2)/3, height: 3,alignment: .top)
            
            
            ZStack(alignment:.top){
                
                VStack(alignment:.leading){
                    
                    FloatingLabelTextField(placeHolder: "Candidates's Name", text: self.$candidateName, color: self.$candidateNameColor)
                    
                    
                    Buttons(label: "Add Candidate", icon:"person.badge.plus" , backgroundColor: "buttonColor").padding(.top,15).onTapGesture {
                        self.addCandidates(candidatesName: self.candidateName)
                    }
                    
                    
                    Spacer()
                    
                    List {
                        ForEach(self.candidateList, id: \.self) { candidate in
                            VStack(alignment:.leading) {
                                
                                Text(candidate)
                                    .font(.system(size: 20))
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .frame(height: 50)
                                    .foregroundColor(Color("textColor"))
                                
                            }
                            .background(Color.clear)
                            

                        }.onDelete(perform: self.delete)
                        
                    } .listStyle(GroupedListStyle())
                        .padding(.horizontal, -20)
                        .environment(\.horizontalSizeClass, .regular)
                        //showing toast with error
                        .toast(isShowing: self.$showError, text: "Please enter at least one candidate")
                    
                    
                    NavigationLink(destination:VotingAlgorithm(electionName: self.$electionName,rootIsActive: self.$rootIsActive),isActive: self.$navigate) {
                        Buttons(label: "Next", icon:"arrow.right" , backgroundColor: "buttonColor").onTapGesture(perform: {
                            if(self.candidateList.count==0){
                                self.showError = true
                                
                            }
                            else{
                                self.saveDataToDatabase()
                                self.showError = false
                                self.navigate = true
                            }
                        }).frame(minWidth: 0, maxWidth: .infinity,alignment: .bottom)
                        
                    } .isDetailLink(false)
                      
                } .padding()
                 .background(Color("backgroundColor"))
                
            }
            Spacer()
                .navigationBarTitle("Add Candidates",displayMode: .automatic)
                .background(Color("backgroundColor"))
            
        }
    }
}

struct AddCandidates_Previews: PreviewProvider {
    static var previews: some View {
        AddCandidates()
    }
}

//MARK: - functions of this view

extension AddCandidates {
    func delete(at offsets: IndexSet) {
        candidateList.remove(atOffsets: offsets)
    }
    
    func addCandidates(candidatesName: String){
        if candidateName != ""{
            candidateList.append(candidateName)
            self.candidateName = ""
        }
        
    }
    
    func saveDataToDatabase(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Election")
        fetchRequest.predicate = NSPredicate(format: "electionName = %@", String(electionName))
        do{
            //getting previous saved election details from the database and adding candidate list
            
            if let fetchResults = try context.fetch(fetchRequest) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    let managedObject = fetchResults[0]
                    let arrayAsString: String = self.candidateList.description
                    managedObject.setValue(arrayAsString, forKey: "electionCandidates")
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

















