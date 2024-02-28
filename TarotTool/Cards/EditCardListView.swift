//
//  EditCardListView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/22/24.
//

import SwiftData
import SwiftUI


struct EditCardListView: View {
    @Environment(\.modelContext) var modelContext
//    @Bindable var reading: Reading
    @Bindable var hasCardList: HasCards
    
    @Query(sort: [
        SortDescriptor(\Card.name)
    ]) var cardList: [Card]
    
    var body: some View {
        let cards = hasCardList.getCardList()
        List {
            ForEach(cardList) { card in
                HStack {
                    Image(systemName: "checkmark")
                        .opacity(cards.contains(card) ? 1.0 : 0.0)
                    Text(card.name)
                }
                .onTapGesture {
                    cardSelect(card: card)
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(card)
                    }
                }
            }
        }
    }
    
    func cardSelect(card: Card) {
        let cards = hasCardList.getCardList()
        if cards.contains(card)  {
            hasCardList.removeCard(card: card)
        } else {
            hasCardList.addCard(card: card)
        }
    }
}

// crashL backingdata Unknown related type - Card
//#Preview {
//    do {
//        let previewer = try Previewer()
//        
//        return EditCardListView(hasCardList: HasCards(hasCardList: previewer.reading))
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}
