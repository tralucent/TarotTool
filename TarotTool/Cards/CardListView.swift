//
//  CardListView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/31/24.
//

import SwiftData
import SwiftUI

struct CardListView: View {
    @Bindable var hasCardList: HasCards
    
    var body: some View {
        let cards = hasCardList.getCardList()

        List {
            ForEach(cards) { card in
                Text(card.name)
            }
        }
    }
}

// Preview is crashing with something about an unknown type Card?
//#Preview {
//    do {
//        let previewer = try Previewer()
//
//        return CardListView(hasCardList: HasCards(hasCardList: previewer.reading))
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}

