//
//  EditReadingView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/15/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditReadingView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var reading: Reading
    @Binding var navigationPath: NavigationPath
    
    @State private var selectedItem: PhotosPickerItem?
    
    @Query(sort: [
        SortDescriptor(\Card.name)
    ]) var cards: [Card]
    @Query(sort: [
        SortDescriptor(\Spread.name)
    ]) var spreads: [Spread]
    
    var body: some View {
        Form {
            Section("Reading Details") {
                TextField("Reading", text: $reading.name)
                    .textContentType(.name)
                
                TextField("Query", text: $reading.query)
                
                List {
                    ForEach(reading.deck!) { deck in
                        Text(deck.name)
                    }
                }
                
                Picker("Choose a spread", selection: $reading.spread) {
                    ForEach(spreads) { spread in
                        Text(spread.name)
                    }
                }
                
                if reading.spread != nil {
                    Text(reading.spread!.name)
                }

            }
            
            Section("Cards Drawn") {
                EditCardListView(hasCardList: HasCards(hasCardList: reading))
//                List {
//                    ForEach(reading.cards!) { card in
//                        Text(card.name)
//                    }
//                }
            }
            
            Section {
                NavigationLink(destination: EditReadingCardsView(reading: reading)) {
                    Text("Select cards")
                        .tint(.blue)
                }

                Button("Add new card", action: addCard)
            }
            
            Section {
                if let imageData = reading.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label(reading.photo == nil ? "Select an image" : "Change image", systemImage: "photo")
                }
            }

            Section("Further Information") {
                TextField("Notes on this reading", text: $reading.notes, axis: .vertical)
            }
        }
        .onChange(of: selectedItem, loadImage)
        .navigationTitle("Edit Reading")
        .navigationBarTitleDisplayMode(.inline)
    }
    
//    func cardSelect(card: Card) {
//        // force unwraping should be safe here, do i need/want more checks?
//        if reading.cards!.contains(card)  {
//            reading.cards?.removeAll(where: { $0 == card })
//        } else {
//            reading.cards!.append(card)
//        }
//    }
    
    func addCard() {
        let card = Card(name: "", details: "", notes: "", history: "", meaning: "", associations: "")
        modelContext.insert(card)
        reading.cards!.append(card)
        navigationPath.append(card)
    }
    
    func loadImage() {
        Task { @MainActor in
            reading.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
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
