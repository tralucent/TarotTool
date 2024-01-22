//
//  Previewer.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/18/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let reading: Reading
    let card: Card
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Reading.self, configurations: config)
        
        card = Card(name: "The Fool", details: "A leap of faith. Beginings", notes: "There never was any solid ground to begin with", readings: [])
        reading = Reading(name: "Year ahead", layout: "1 card", query: "What is the theme for my year", deck: "", cards: [card], notes: "One small step")
        
        container.mainContext.insert(reading)
    }
}
