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
    
    @BlackbirdLiveModels({ db in
        try await MoodItem.read(from: db)
    }) var moodItems
    
    @State var newItemDescription: String = " "
    @State var newItemEmoji: String = " "
    
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    TextField("__", text: $newItemEmoji)
                        .frame(maxWidth: 50)
                        .font(.largeTitle)
                    
                    TextField("Enter your mood", text: $newItemDescription)
                        .font(.title2)
                        .textCase(.uppercase)
                    
                    Button(action: {
                        
                        Task {
                        try await db!.transaction { core in
                            try core.query("INSERT INTO MoodItem (description) VALUES (?)", newItemDescription)
                            
                        }
                        newItemDescription = " "
                            
                    }
                        Task {
                        try await db!.transaction { core in
                            try core.query("INSERT INTO MoodItem (emoji) VALUES (?)", newItemEmoji)
                            
                        }
                        newItemEmoji = " "
                            
                    }

                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                }
                .padding(20)
                
                List {
                    
                    ForEach(moodItems.results) { currentItem in
                        
                        Label(title: {
                            Text(currentItem.description)
                                .textCase(.uppercase)
                        }, icon: {
                            Text(currentItem.emoji)
                                
                        })
                        
                        
                        
                    }

                }
                
                            }
            .navigationTitle("Mood Mapper")
        }
    }
    
    
    // MARK: Functions
    func removeRows(at offsets: IndexSet) {
        
        Task {
            
            try await db!.transaction { core in
                
                var idList = ""
                for offset in offsets {
                    idList += "\(moodItems.results[offset].id),"
                }
                
                print(idList)
                idList.removeLast()
                print(idList)
                
                try core.query("DELETE FROM MoodItem WHERE id IN (?)",
                               idList)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
