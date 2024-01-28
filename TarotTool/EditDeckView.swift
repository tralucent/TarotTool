//
//  EditDeckView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/27/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditDeckView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var deck: Deck
    @State private var selectedItem: PhotosPickerItem?
    
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
            Section {
                TextField("Notes", text: $deck.notes)
            }
        }
        .onChange(of: selectedItem, loadImage)
    }
    
    func loadImage() {
        Task { @MainActor in
            deck.image = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

//#Preview {
//    EditDeckView()
//}
