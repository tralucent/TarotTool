//
//  DeckListView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/27/24.
//

import SwiftData
import SwiftUI

struct DeckListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var decks: [Deck]
    
    var body: some View {
        List {
            ForEach(decks) { deck in
                NavigationLink(value: deck) {
                    Text(deck.name)
                }
            }
        }
    }
}

#Preview {
    DeckListView()
}
