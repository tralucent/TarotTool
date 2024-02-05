//
//  Card.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 12/1/23.
//

import Foundation
import SwiftData

@Model
class Card: Codable {
    struct CardType: Codable {
        enum arcana: Codable {
            case major, minor, court, nonstandard
        }

        enum suits: Codable {
            case swords, wands, cups, pentacles, none
        }
        
        var acane: arcana
        var suit: suits
        var fancySuitNames: [suits: String] = [.swords: "Swords", .wands: "Wands", .cups: "Cups", .pentacles: "Pentacles", .none: "N/A"]
        var number: Int
        
        var fancyName: String {
            return fancySuitNames[suit] ?? ""
        }
        
    }

    var name: String = ""
    var type: CardType? = nil
    var order: Int = -1
    var details: String = ""
    var notes: String = ""
    var history: String = ""
    var meaning: String = ""
    var associations: String = ""
    var deck: Deck?
    var readings: [Reading]? = [Reading]()
    @Attribute(.externalStorage) var image: Data?
    
    init(name: String, type: CardType? = nil, order: Int, details: String, notes: String, history: String, meaning: String, associations: String, deck: Deck? = nil, readings: [Reading]? = [], image: Data? = nil) {
        self.name = name
        self.type = type
        self.order = order
        self.details = details
        self.notes = notes
        self.history = history
        self.meaning = meaning
        self.associations = associations
        self.deck = deck
        self.readings = readings
        self.image = image
    }
    
    /// I am choosing not to encode deck or readings to avoid potential loops.
    enum CodingKeys: String, CodingKey {
        case name, type, order, details, notes, history, meaning, associations, image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.name = container.decode(String.self, forKey: .name)
        try self.type = container.decodeIfPresent(CardType.self, forKey: .type)
        try self.order = container.decode(Int.self, forKey: .order)
        try self.details = container.decode(String.self, forKey: .details)
        try self.notes = container.decode(String.self, forKey: .notes)
        try self.history = container.decode(String.self, forKey: .history)
        try self.meaning = container.decode(String.self, forKey: .meaning)
        try self.associations = container.decode(String.self, forKey: .associations)
        // when I'm ready: https://xavier7t.com/encode-decode-an-image-with-swift
//        try self.image = container.decodeIfPresent(Data.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name.self, forKey: .name)
        try container.encodeIfPresent(type.self, forKey: .type)
        try container.encode(order.self, forKey: .order)
        try container.encode(details.self, forKey: .details)
        try container.encode(notes.self, forKey: .notes)
        try container.encode(history.self, forKey: .history)
        try container.encode(meaning.self, forKey: .meaning)
        try container.encode(associations.self, forKey: .associations)
        // when I'm ready: https://xavier7t.com/encode-decode-an-image-with-swift
//        try container.encodeIfPresent(image.self, forKey: .image)
    }
}

protocol HasCardList: Observable {
    associatedtype T
    
    var cards: [Card]? { get set }

}

// this is a parent class for a class that has a list of cards: [Card]
class HasCards: Observable {
    
    var hasCardList: any HasCardList
    
    init(hasCardList: any HasCardList) {
        self.hasCardList = hasCardList
    }
    
    func getCardList() -> [Card] {
        hasCardList.cards!
    }
    
    func addCard(card: Card) {
        hasCardList.cards!.append(card)
    }
    
    func removeCard(card: Card) {
        hasCardList.cards!.removeAll(where: { $0 == card })
    }
}
