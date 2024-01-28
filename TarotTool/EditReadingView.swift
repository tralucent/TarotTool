//
//  EditReadingView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/15/24.
//

import SwiftData
import SwiftUI

struct EditReadingView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var reading: Reading
    @Binding var navigationPath: NavigationPath
    
    @Query(sort: [
        SortDescriptor(\Card.name)
    ]) var cards: [Card]
    
    var body: some View {
        Form {
            Section("Reading Details") {
                TextField("Reading", text: $reading.name)
                    .textContentType(.name)
                
                TextField("Query", text: $reading.query)
                
                TextField("Deck", text: $reading.deck)
                
                if reading.spread != nil {
                    Text(reading.spread!.name)
                }

            }
            
            Section("Cards Drawn") {
                List {
                    ForEach(reading.cards!) { card in
                        Text(card.name)
                    }
                }
            }
            
            Section {
                NavigationLink(destination: EditReadingCardsView(reading: reading)) {
                    Text("Select cards")
                        .tint(.blue)
                }

                Button("Add new card", action: addCard)
            }

            Section("Further Information") {
                TextField("Notes on this reading", text: $reading.notes, axis: .vertical)
            }
        }
        .navigationTitle("Edit Reading")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Card.self) { card in
            EditCardView(card: card)
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
    
    func addCard() {
        let card = Card(name: "", details: "", notes: "", history: "", meaning: "", associations: "")
        modelContext.insert(card)
        reading.cards!.append(card)
        navigationPath.append(card)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return EditReadingView(reading: previewer.reading, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
