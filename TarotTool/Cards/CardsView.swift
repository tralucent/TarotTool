//
//  CardsView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/25/24.
//

import SwiftData
import SwiftUI

struct CardsView: View {
    @Environment(\.modelContext) var modelContext
    
    var deck: Deck?
    
    @Query(sort: [
        SortDescriptor(\Card.name)
    ]) var cardList: [Card]
    
    var body: some View {
        if deck == nil {
            List {
                ForEach(cardList) { card in
                    NavigationLink(value: card) {
                        Text(card.name)
                    }
                }
                .onDelete(perform: deleteCards)
            }
        } else {
            CardListView(hasCardList: HasCards(hasCardList: deck!))
        }
    }
    
    init(deck: Deck? = nil, searchString: String = "", sortOrder: [SortDescriptor<Card>] = [SortDescriptor(\Card.order), SortDescriptor(\Card.name)]) {
        self.deck = deck
        _cardList = Query(filter: #Predicate { card in
            if searchString.isEmpty {
                true
            } else {
                card.name.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    func deleteCards(at offsets: IndexSet) {
        for offset in offsets {
            let card = cardList[offset]
            modelContext.delete(card)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return CardsView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
