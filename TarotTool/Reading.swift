//
//  Reading.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/15/24.
//

import Foundation
import SwiftData

@Model
class Reading: HasCardList, Codable {
    typealias T = Reading
    
    var name: String = ""
    var spread: Spread?
    var query: String = ""
    var deck: [Deck]? = [Deck]()
    var cards: [Card]? = [Card]()
    var highlights: String = ""
    var notes: String = ""
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, spread: Spread? = nil, query: String, deck: [Deck] = [], cards: [Card]? = [], highlights: String, notes: String, photo: Data? = nil) {
        self.name = name
        self.spread = spread
        self.query = query
        self.deck = deck
        self.cards = cards
        self.highlights = highlights
        self.notes = notes
        self.photo = photo
    }
    
    enum CodingKeys: CodingKey {
        case name, spread, query, deck, cards, highlights, notes, photo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.name = container.decode(String.self, forKey: .name)
        try self.spread = container.decodeIfPresent(Spread.self, forKey: .spread)
        try self.query = container.decode(String.self, forKey: .query)
        // decks...
//        try self.deck = container.decodeIfPresent([Deck].self, forKey: .deck)
        try self.cards = container.decodeIfPresent([Card].self, forKey: .cards)
        try self.highlights = container.decode(String.self, forKey: .highlights)
        try self.notes = container.decode(String.self, forKey: .notes)
        // photo when i'm ready
//        try self.photo = container.decodeIfPresent(Data.self, forKey: .photo)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(spread, forKey: .spread)
        try container.encode(query, forKey: .query)
        // decks...
//        try container.encodeIfPresent(deck, forKey: .deck)
        try container.encodeIfPresent(cards, forKey: .cards)
        try container.encode(highlights, forKey: .highlights)
        try container.encode(notes, forKey: .notes)
        // photo when i'm ready
//        try container.encodeIfPresent(photo, forKey: .photo)
    }
}
