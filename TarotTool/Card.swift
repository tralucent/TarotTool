//
//  Card.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 12/1/23.
//

import Foundation
import SwiftData

@Model
class Card {
    var name: String = ""
    var details: String = ""
    var notes: String = ""
    var deck: Deck?
    var readings: [Reading]? = [Reading]()
    
    init(name: String, details: String, notes: String, deck: Deck? = nil, readings: [Reading]) {
        self.name = name
        self.details = details
        self.notes = notes
        self.deck = deck
        self.readings = readings
    }
}
