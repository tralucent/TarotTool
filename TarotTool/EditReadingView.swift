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
    @State private var selectedDeck: Deck?
    
    @Query(sort: [
        SortDescriptor(\Card.name)
    ]) var cards: [Card]
    @Query(sort: [
        SortDescriptor(\Spread.name)
    ]) var spreads: [Spread]
    @Query(sort: [
        SortDescriptor(\Deck.name)
    ]) var decks: [Deck]
    
    var body: some View {
        Form {
            Section("Reading Details") {
                TextField("Reading", text: $reading.name)
                    .textContentType(.name)
                
                TextField("Query", text: $reading.query)
                
                Picker("Choose a Deck", selection: $selectedDeck) {
                    Text("None").tag(nil as Deck?)
                    ForEach(decks) { deck in
                        Text(deck.name).tag(deck.self as Deck?)
                    }
                }
                
                Picker("Choose a spread", selection: $reading.spread) {
                    Text("None").tag(nil as Spread?)
                    ForEach(spreads) { spread in
                        Text(spread.name).tag(spread.self as Spread?)
                    }
                }
                
                if reading.spread != nil {
                    Text(reading.spread!.name)
                }

            }
            
            Section("Cards Drawn") {
                CardListView(hasCardList: HasCards(hasCardList: reading))
            }
            
            Section {
                NavigationLink(destination: EditCardListView(hasCardList: HasCards(hasCardList: reading))) {
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
        .onAppear(perform: loadDeck)
        .onChange(of: selectedDeck, setDeck)
        .onChange(of: selectedItem, loadImage)
        .navigationTitle("Edit Reading")
        .navigationBarTitleDisplayMode(.inline)
    }

    func addCard() {
        let card = Card(name: "", details: "", notes: "", history: "", meaning: "", associations: "")
        modelContext.insert(card)
        reading.cards!.append(card)
        navigationPath.append(card)
    }
    
    func loadDeck() {
        if !(reading.deck?.isEmpty ?? true) {
            selectedDeck = reading.deck![0]
        }
    }
    
    func setDeck() {
        reading.deck = [selectedDeck!]
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
