//
//  Home.swift
//  Agora iOS
//
//  Created by Akash Chaudhary on 22/03/20.
//  Copyright © 2020 Akash Chaudhary. All rights reserved.
//

import SwiftUI
import CoreData

struct Home: View {
    //bindig the index value of TabView
    @Binding var index: Int
    //enable or disable the navigation link to create election
    @State var isActive: Bool = false
    //number of elections created and saved in database
    @State var activeElections: Int = 0

    public init(index: Binding<Int>){
        self._index = index
        //changing back button color to green
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.09019607843, green: 0.6823529412, blue: 0.3764705882, alpha: 1)
     }
   
    var body: some View {
      NavigationView{
        
            VStack(alignment: .leading){
                
                HStack(){
                    CardView(icon: "total", title: "Total", number: 10)
                    CardView(icon: "pending", title: "Pending", number:3)
                } .padding()
                
                HStack(){
                    CardView(icon: "active", title: "Active", number: activeElections)
                    CardView(icon: "finished", title: "Finished", number: 6)
                }.padding()

                NavigationLink(destination: ElectionDetail(rootIsActive: $isActive),isActive: self.$isActive) {
                    
                    Buttons(label: "Create Election", icon:"plus" , backgroundColor: "buttonColor")
                        .padding(EdgeInsets(top: 10, leading:25, bottom: 20
                            , trailing: 25))
                        
                }.navigationBarTitle("Dashboard")
                
                 TabView(index: $index)
                
            }.padding(.top,15)
             .background(Color("backgroundColor"))
            
      }.onAppear {
        self.getElections()
        }
        
    }
    
}

struct Home_Previews: PreviewProvider {

    static var previews: some View {
        Home(index: .constant(0))
    }
}

//MARK: - Cards for showing different elections such as pending , finished....


struct CardView: View {
    
    @State var icon: String
    @State var title: String
    @State var number: Int
    
    var body: some View {

        GeometryReader { geometry in
           VStack{
                Image(self.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .minimumScaleFactor(0.8)
                    .frame(height:geometry.size.height/2.7,alignment:.top)
                    .padding(EdgeInsets(top: 20, leading:0, bottom: 0
                        , trailing: 0))
                
                Text(self.title)
                    .font(.system( size:geometry.size.height/9))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: (geometry.size.height/25), leading:0, bottom: 0
                        , trailing: 0))
                
                Divider()
                    .background(Color.white)
                    .padding(EdgeInsets(top:0, leading:15, bottom: 0
                        , trailing: 15))
                
                Text(String(self.number))
                    .font(.system(size:geometry.size.height/5))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top:  -(geometry.size.height/20), leading:0, bottom: 10
                        , trailing: 0))
                                
            } .frame(width: (geometry.size.width), height: geometry.size.height+40)
                .background( RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("redColor"))
                .shadow(color: Color.gray, radius: 1, x: 1, y: 1))
            
        } .padding(EdgeInsets(top: 8, leading:8, bottom: 8
            , trailing: 8))
            .onAppear {
               
        }
     
    }
    
}


//MARK: - functions to retrieve saved elections from the database

extension Home{
    func getElections(){
          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Election")
          
          do{
              if let elections = try context.fetch(fetchRequest) as? [NSManagedObject] {
                  if elections.count != 0{
                    self.activeElections = elections.count
                  }
              }
          }catch{
              print(Error.self)
          }
          
      }
}




