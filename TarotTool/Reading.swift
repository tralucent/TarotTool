//
//  Reading.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/15/24.
//

import Foundation
import SwiftData

@Model
class Reading: HasCardList {
    typealias T = Reading
    
    var name: String = ""
    var spread: Spread?
    var query: String = ""
    var deck: [Deck]? = [Deck]()
    var cards: [Card]? = [Card]()
    var highlights: String = ""
    var notes: String = ""
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, spread: Spread? = nil, query: String, deck: [Deck], cards: [Card]? = nil, highlights: String, notes: String, photo: Data? = nil) {
        self.name = name
        self.spread = spread
        self.query = query
        self.deck = deck
        self.cards = cards
        self.highlights = highlights
        self.notes = notes
        self.photo = photo
    }

    func getCardList() -> [Card] {
        cards!
    }
}
