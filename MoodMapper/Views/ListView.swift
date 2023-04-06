//
//  ListView.swift
//  MoodMapper
//
//  Created by Aidan Kang on 2023-04-06.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    TextField("__", text: Binding.constant(""))
                        .frame(maxWidth: 50)
                        .font(.largeTitle)
                    
                    TextField("Enter your mood", text: Binding.constant(""))
                        .font(.title2)
                        .textCase(.uppercase)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                }
                .padding(20)
                
                List(existingMoodItems) { currentItem in
                    
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
