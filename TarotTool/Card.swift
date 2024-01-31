//
//  Card.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 12/1/23.
//

import Foundation
import SwiftData

struct type {
    enum arcana {
        case major, minor, court, nonstandard
    }

    enum suits {
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

@Model
class Card {
    var name: String = ""
    var details: String = ""
    var notes: String = ""
    var history: String = ""
    var meaning: String = ""
    var associations: String = ""
    var deck: Deck?
    var readings: [Reading]? = [Reading]()
    @Attribute(.externalStorage) var image: Data?
    
    init(name: String, details: String, notes: String, history: String, meaning: String, associations: String, deck: Deck? = nil, readings: [Reading]? = nil, image: Data? = nil) {
        self.name = name
        self.details = details
        self.notes = notes
        self.history = history
        self.meaning = meaning
        self.associations = associations
        self.deck = deck
        self.readings = readings
        self.image = image
    }
}

protocol HasCardList: Observable {
    associatedtype T
    
    var cards: [Card]? { get set }

}

// this is a wrapper class for a class that has a list of cards: [Card]
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
