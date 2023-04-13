//
//  ListItemsView.swift
//  MoodMapper
//
//  Created by Aidan Kang on 2023-04-13.
//

import Blackbird
import SwiftUI

struct ListItemsView: View {
    
    
    // MARK: Stored properties
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveModels var moodItems: Blackbird.LiveResults<MoodItem>
    
    // MARK: Computed properties
    var body: some View {
        List {
            
            ForEach(moodItems.results) { currentItem in
                
                Label(title: {
                    Text(currentItem.description)
                        .textCase(.uppercase)
                }, icon: {
                    Text(currentItem.emoji)
                        
                })
                
                
                
            }
            .onDelete(perform: removeRows)
        }
    }
    // MARK: Initializers
    init(filteredOn searchText: String) {
        
        _moodItems = BlackbirdLiveModels({ db in
            try await MoodItem.read(from: db,
                                    sqlWhere: "description LIKE?", "%\(searchText)%")
        })
        
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

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(filteredOn: "")
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
