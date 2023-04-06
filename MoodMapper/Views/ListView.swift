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
                
                List(moodItems.results) { currentItem in
                    
                    Label(title: {
                        Text(currentItem.description)
                            .textCase(.uppercase)
                    }, icon: {
                        Text(currentItem.emoji)
                            
                    })
                    
                    
                    
                }
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
