//
//  Deck.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/16/24.
//

import Foundation
import SwiftData

@Model
class Deck: HasCardList, Codable {
    typealias T = Deck
    
    enum DeckType: Codable {
        case tarot, oracle, lenormand, other
    }
    
    enum Element: String, Codable {
        case air = "Air"
        case earth = "Earth"
        case fire = "Fire"
        case water = "Water"
    }
    
    var name: String = ""
    var author: String = ""
    var artist: String = ""
    //var deckType: DeckType = DeckType.tarot
    //var suitNames: [Element: String] = [.air: "Swords", .earth: "Pentacles", .fire: "Wands", .water: "Cups"]
    var details: String = ""
    var history: String = ""
    var notes: String = ""
    var cards: [Card]? = [Card]()
    var readings: [Reading]? = [Reading]()
    @Attribute(.externalStorage) var image: Data?
    @Attribute(.externalStorage) var cardBack: Data?
    
    init(name: String, author: String, artist: String, details: String, history: String, notes: String, cards: [Card]? = [], readings: [Reading]? = [], image: Data? = nil, cardBack: Data? = nil) {
        self.name = name
        self.author = author
        self.artist = artist
        //self.deckType = deckType
        //, deckType: DeckType = .tarot
        self.details = details
        self.history = history
        self.notes = notes
        self.cards = cards
        self.image = image
        self.cardBack = cardBack
    }
    
    enum CodingKeys: CodingKey {
        case name, author, artist, deckType, details, history, notes, cards, image, cardBack
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.name = container.decode(String.self, forKey: .name)
        try self.author = container.decode(String.self, forKey: .author)
        try self.artist = container.decode(String.self, forKey: .artist)
        //try self.deckType = container.decode(DeckType.self, forKey: .deckType)
        try self.details = container.decode(String.self, forKey: .details)
        try self.history = container.decode(String.self, forKey: .history)
        try self.notes = container.decode(String.self, forKey: .notes)
        // hopefully swift just uses the card decode and all is well
        try self.cards = container.decodeIfPresent([Card].self, forKey: .cards)
        // images when i'm ready.
//        try self.image = container.decodeIfPresent(Data.self, forKey: .image)
//        try self.image = container.decodeIfPresent(Data.self, forKey: .cardBack)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(author, forKey: .author)
        try container.encode(artist, forKey: .artist)
        //try container.encode(deckType, forKey: .deckType)
        try container.encode(details, forKey: .details)
        try container.encode(history, forKey: .history)
        try container.encode(notes, forKey: .notes)
        // hopefully swift uses the card encode function and all is well.
        try container.encodeIfPresent(cards, forKey: .cards)
        // images when i'm ready
//        try container.encodeIfPresent(image, forKey: .image)
//        try container.encodeIfPresent(cardBack, forKey: .cardBack)
    }
}
