//
//  Spread.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/26/24.
//

import Foundation
import SwiftData

@Model
class Spread: Codable {
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
    
    enum CodingKeys: CodingKey {
        case name, details, notes, numberOfCards, history, image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.name = container.decode(String.self, forKey: .name)
        try self.details = container.decode(String.self, forKey: .details)
        try self.notes = container.decode(String.self, forKey: .notes)
        try self.numberOfCards = container.decode(Int.self, forKey: .numberOfCards)
        try self.history = container.decode(String.self, forKey: .history)
        // image when i'm ready
//        try self.image = container.decodeIfPresent(Data.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(details, forKey: .details)
        try container.encode(notes, forKey: .notes)
        try container.encode(numberOfCards, forKey: .numberOfCards)
        try container.encode(history, forKey: .history)
        // image when i'm ready
//        try container.encode(image, forKey: .image)
    }
}
