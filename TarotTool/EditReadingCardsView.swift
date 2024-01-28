//
//  EditReadingCardsView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/22/24.
//

import SwiftData
import SwiftUI


struct EditReadingCardsView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var reading: Reading
    
    @Query(sort: [
        SortDescriptor(\Card.name)
    ]) var cardList: [Card]
    
    var body: some View {
        List {
            ForEach(cardList) { card in
                HStack {
                    Image(systemName: "checkmark")
                        .opacity(reading.cards!.contains(card) ? 1.0 : 0.0)
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
        // force unwraping should be safe here, do i need/want more checks?
        if reading.cards!.contains(card)  {
            reading.cards?.removeAll(where: { $0 == card })
        } else {
            reading.cards!.append(card)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return EditReadingCardsView(reading: previewer.reading)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
