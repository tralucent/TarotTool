//
//  EditCardView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/16/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditCardView: View {
    @Bindable var card: Card
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        Form {
            Section {
                if let imageData = card.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label(card.image == nil ? "Select an image" : "Change image", systemImage: "photo")
                }
            }
            Section {
                TextField("Card name", text: $card.name)
                TextField("Card details", text: $card.details, axis: .vertical)
            }
            
            Section("Notes") {
                TextField("Notes", text: $card.notes, axis: .vertical)
            }
        }
        .onChange(of: selectedItem, loadImage)
    }
    
    func loadImage() {
        Task { @MainActor in
            card.image = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

//#Preview {
//    EditCardView()
//}
