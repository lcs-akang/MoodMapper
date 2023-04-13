//
//  ListView.swift
//  MoodMapper
//
//  Created by Aidan Kang on 2023-04-06.
//

import Blackbird
import SwiftUI

struct ListView: View {
    
    // MARK: Stored properties
    
    @Environment(\.blackbirdDatabase) var db:
    Blackbird.Database?
    
    
    @State var newItemDescription: String = " "
    
    @State var newItemEmoji: String = " "
    
    @State var searchText = " "
    
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    TextField("_", text: $newItemEmoji)
                        .frame(maxWidth: 50)
                        .font(.largeTitle)
                    
                    TextField("Enter your mood", text: $newItemDescription)
                        .font(.title2)
                        .textCase(.uppercase)
                    
                    Button(action: {
                        
                        Task {
                        try await db!.transaction { core in
                            try core.query("INSERT INTO MoodItem (description, emoji) VALUES (?,?)", newItemDescription, newItemEmoji)
                            
                        }
                        newItemDescription = " "
                        newItemEmoji = " "
                            
//                        try await db!.transaction { core in
//                            try core.query("INSERT INTO MoodItem (emoji) VALUES (?)", newItemEmoji)
//
//                        }
//                        newItemEmoji = " "
//
                    }

                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                }
                .padding(20)
                
                ListItemsView(filteredOn: searchText)
                .searchable(text: $searchText)
            }
            .navigationTitle("Mood Mapper")
        }
    }
    
    

}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
