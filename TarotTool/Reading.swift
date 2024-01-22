//
//  Reading.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/15/24.
//

import Foundation
import SwiftData

@Model
class Reading {
    var name: String = ""
    var layout: String = ""
    var query: String = ""
    var deck: String = ""
    var cards: [Card]? = [Card]()
    var notes: String = ""
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, layout: String, query: String, deck: String, cards: [Card], notes: String) {
        self.name = name
        self.layout = layout
        self.query = query
        self.deck = deck
        self.cards = cards
        self.notes = notes
    }
}
