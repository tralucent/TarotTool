//
//  CardListView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/25/24.
//

import SwiftData
import SwiftUI

struct CardListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [
        SortDescriptor(\Card.name)
    ]) var cardList: [Card]
    
    var body: some View {
        List {
            ForEach(cardList) { card in
                NavigationLink(value: card) {
                    Text(card.name)
                }
            }
            .onDelete(perform: deleteCards)
        }
    }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Card>] = []) {
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
        
        return CardListView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
