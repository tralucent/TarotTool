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
    let deck: Deck
    let spread: Spread
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Reading.self, configurations: config)
        
        spread = Spread(name: "Single Card", details: "A single card draw. Could be used for many purposes: a quick check in with spirit, a card for the day, or an answer to a question - avoid yes or no questions", notes: "", numberOfCards: 1, history: "", image: nil)
        deck = Deck(name: "Smith Rider Waite", author: "Rider-Waite", artist: "Pamela Colerman Smith", details: "A traditional deck that most modern decks take some to much inspiration from", history: "", notes: "")
        card = Card(name: "The Fool", type: nil, order: 0, details: "A leap of faith. Beginings", notes: "There never was any solid ground to begin with", history: "", meaning: "", associations: "", deck: deck)
        reading = Reading(name: "Year ahead", spread: spread, query: "What is the theme for my year", deck: [], cards: [card], highlights: "", notes: "One small step")
        
        container.mainContext.insert(reading)
    }
}
