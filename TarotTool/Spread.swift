//
//  Spread.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/26/24.
//

import Foundation
import SwiftData

@Model
class Spread {
    var name: String = ""
    var details: String = ""
    var notes: String = ""
    var numberOfCards: Int = 1
    var history: String = ""
    @Attribute(.externalStorage) var image: Data?
    var readings: [Reading] = [Reading]()
    
    init(name: String, details: String, notes: String, numberOfCards: Int, history: String, image: Data? = nil) {
        self.name = name
        self.details = details
        self.notes = notes
        self.numberOfCards = numberOfCards
        self.history = history
        self.image = image
    }
}
