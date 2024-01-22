//
//  ContentView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 12/1/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    
    @State private var sortOrder = [SortDescriptor(\Reading.name)]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            ReadingView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("TarotTool")
            .navigationDestination(for: Reading.self) { reading in
                EditReadingView(reading: reading, navigationPath: $path)
            }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name (A-Z")
                            .tag([SortDescriptor(\Reading.name)])
                        
                        Text("Name (Z-A")
                            .tag([SortDescriptor(\Reading.name, order: .reverse)])
                    }
                }
                
                Button("Add Reading", systemImage: "plus", action: addReading)
            }
            .searchable(text: $searchText)
        }
    }
    
    func addReading() {
        let reading = Reading(name: "", layout: "", query: "", deck: "", cards: [], notes: "")
        modelContext.insert(reading)
        path.append(reading)
    }
}

#Preview {
    ContentView()
}
