//
//  EditCardListView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/31/24.
//

import SwiftData
import SwiftUI

struct EditCardListView: View {
    @Bindable var hasCardList: HasCards
    
    var body: some View {
//        Form {
        let cards = hasCardList.getCardList()
            List {
                ForEach(cards) { card in
                    Text(card.name)
                }
            }
//        }
    }
}

//#Preview {
//    do {
//        let previewer = try Previewer()
//        
//        return EditCardListView(hasCardList: HasCards(deck: previewer.deck))
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}
