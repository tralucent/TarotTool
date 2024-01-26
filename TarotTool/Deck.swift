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
    var history: String = ""
    var notes: String = ""
    var cards: [Card]? = [Card]()
    @Attribute(.externalStorage) var image: Data?
    @Attribute(.externalStorage) var cardBack: Data?
    
    init(name: String, author: String, artist: String, details: String, history: String, notes: String, cards: [Card]? = nil, image: Data? = nil, cardBack: Data? = nil) {
        self.name = name
        self.author = author
        self.artist = artist
        self.details = details
        self.history = history
        self.notes = notes
        self.cards = cards
        self.image = image
        self.cardBack = cardBack
    }
}
