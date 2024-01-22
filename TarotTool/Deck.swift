//
//  Deck.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/16/24.
//

import Foundation
import SwiftData

@Model
class Deck {
    var name: String = ""
    var author: String = ""
    var artist: String = ""
    var details: String = ""
    var cards: [Card]? = [Card]()
    
    init(name: String, author: String, artist: String, details: String, cards: [Card] = []) {
        self.name = name
        self.author = author
        self.artist = artist
        self.details = details
        self.cards = cards
    }
}
