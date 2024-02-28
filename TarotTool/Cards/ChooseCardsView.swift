//
//  ChooseCardsView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/22/24.
//

import SwiftData
import SwiftUI

struct ChooseCardsView: View {
    @Bindable var reading: Reading

    @Query(sort: [
        SortDescriptor(\Card.name)
    ]) var cards: [Card]
    
    var body: some View {
        Form {
            List {
                ForEach(cards, id: \.self) { card in
                    Button(action: { cardSelect(card: card) }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(reading.cards!.contains(card) ? 1.0 : 0.0)
                            Text(card.name)
                        }
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
        
        return ChooseCardsView(reading: previewer.reading)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
//, navigationPath: .constant(NavigationPath())
