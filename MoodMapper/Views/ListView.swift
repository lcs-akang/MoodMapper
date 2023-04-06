//
//  ListView.swift
//  MoodMapper
//
//  Created by Aidan Kang on 2023-04-06.
//

import SwiftUI

struct ListView: View {
    
    // MARK: Stored properties
    
    @State var moodItems: [MoodItem] = existingMoodItems
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
                        
                        let lastId = moodItems.last!.id
                        let newId = lastId + 1
                        let newMoodItem = MoodItem(id: newId,
                                                   description: newItemDescription,
                                                   emoji: newItemEmoji)
                        moodItems.append(newMoodItem)
                        
                        newItemDescription = " "
                        
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                }
                .padding(20)
                
                List(moodItems) { currentItem in
                    
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
