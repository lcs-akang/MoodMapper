//
//  MoodItem.swift
//  MoodMapper
//
//  Created by Aidan Kang on 2023-04-06.
//

import Foundation

struct MoodItem: Identifiable {
    var id: Int
    var description: String
    var emoji: String
}

var existingMoodItems = [

    MoodItem(id: 1, description: "Fantastic", emoji: "👍")
    
    ,
    
    MoodItem(id: 2, description: "Great", emoji: "✅")

    ,
    
    MoodItem(id: 3, description: "Sad", emoji: "😕")
    
    ,
    
]
