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
