//
//  ReadingView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/15/24.
//

import SwiftData
import SwiftUI

struct ReadingsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var readings: [Reading]
    
    var body: some View {
        List {
            ForEach(readings) { reading in
                NavigationLink(value: reading) {
                    VStack {
                        Text(reading.name)
                        Text(reading.query)
                    }
                }
            }
            .onDelete(perform: deleteReadings)
        }
    }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Reading>] = []) {
        _readings = Query(filter: #Predicate { reading in
            if searchString.isEmpty {
                true
            } else {
                reading.name.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    func deleteReadings(at offsets: IndexSet) {
        for offset in offsets {
            let reading = readings[offset]
            modelContext.delete(reading)
        }
    }
}

#Preview {
    ReadingsView()
}
