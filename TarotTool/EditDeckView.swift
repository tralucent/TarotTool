//
//  EditDeckView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/27/24.
//

import PhotosUI
import SwiftData
import SwiftUI

//extension UIImage {
//    func encodedImage(_ imageData: UIImage) -> String {
//        return imageData.pngData()?.base64EncodedString() ?? ""
//    }
//    
//    func decodedImage(_ base64Data: String) -> Image? {
//        guard let imageData = Data(base64Encoded: base64Data) else {
//            return nil
//        }
//        
//        return Image(uiImage: UIImage(data: imageData)!)
//    }
//}

struct EditDeckView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var deck: Deck
    @Binding var navigationPath: NavigationPath
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var url: String = ""
    
    var body: some View {
        Form {
            Section {
                if let imageData = deck.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label(deck.image == nil ? "Select an image" : "Change image", systemImage: "photo")
                }
            }
            
            Section {
                TextField("Name", text: $deck.name)
                TextField("Author", text: $deck.author)
                TextField("Artist", text: $deck.artist)
            }
            
            Section("Cards in deck") {
                CardListView(hasCardList: HasCards(hasCardList: deck))
            }

            Section {
                NavigationLink(destination: EditCardListView(hasCardList: HasCards(hasCardList: deck))) {
                    Text("Select cards")
                        .tint(.blue)
                }

                Button("Add new card", action: addCard)
            }

            Section {
                TextField("Notes", text: $deck.notes)
            }
            
            // This is to allow me to encode the deck and check out it's JSON
            Section {
                // gonna use this to upload a JSON file
                TextField("File url", text: $url)
                // save a JSON file
                Button("Save Deck", action: saveDeck)
            }
        }
        .onChange(of: selectedItem, loadImage)
        .navigationTitle(deck.name.isEmpty ? "Edit Deck" : "Edit \(deck.name)")
        .navigationBarTitleDisplayMode(.inline)
    }

    func addCard() {
        let card = Card(name: "", order: -1, details: "", notes: "", history: "", meaning: "", associations: "", deck: deck)
        modelContext.insert(card)
        deck.cards!.append(card)
        navigationPath.append(card)
    }

    func loadImage() {
        Task { @MainActor in
            deck.image = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
    
    func loadDeck() {
        if !url.isEmpty {
            // try to load the file
        }
    }
    
    func saveDeck() {
        do {
            let encodedDeck = try JSONEncoder().encode(deck)
            let encodedString = String(data: encodedDeck, encoding: .utf8)
            print(encodedString ?? "There was an error encoding the deck.")
            // currently the following isn't working as expected. this may be related to document based apps v swift data.
            // this isn't important compared to loading data in
            let url = URL.documentsDirectory.appending(path: "\(deck.name).json")
            try encodedString?.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print("Deck could not be saved. \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    EditDeckView()
//}
