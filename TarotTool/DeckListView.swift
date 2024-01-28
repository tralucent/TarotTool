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
            .onDelete(perform: deleteDecks)
        }
    }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Deck>] = []) {
        _decks = Query(filter: #Predicate { deck in
            if searchString.isEmpty {
                true
            } else {
                deck.name.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    func deleteDecks(at offsets: IndexSet) {
        for offset in offsets {
            let deck = decks[offset]
            modelContext.delete(deck)
        }
    }
}

#Preview {
    DeckListView()
}
