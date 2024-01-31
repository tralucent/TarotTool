//
//  CardsInDeckView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/29/24.
//

import SwiftData
import SwiftUI

struct CardsInDeckView: View {
    @Bindable var deck: Deck
    
//    @Query var cards: [Card]
        
//    @Query(filter: #Predicate<Card> { card in
//        cards.contains(card)
//    })
    
    var body: some View {
        List {
            ForEach(deck.cards!) { card in
                Text(card.name)
            }
        }
    }

//    init(searchString: String, deck: Deck) {
//        let cardsInDeck = deck.cards ?? []
//        _cards = Query(filter: #Predicate<Card> { card in
//            card.deck != nil
//        })
//    }

//    init(searchString: String, decks: [Deck]) {
//        _cards = Query(filter: #Predicate { card in
//            ForEach(decks) { deck in
//                deck.cards!.contains(card)
//            }
//        })
//    }
}

//#Preview {
//    CardsInDeckView()
//}
