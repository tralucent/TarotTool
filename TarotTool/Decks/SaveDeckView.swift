//
//  SaveDeckView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 2/28/24.
//

import SwiftUI

struct SaveDeckView: View {
    @State private var isPresented = false
    @State private var fileName: String = ""
    var deck: Deck
    
    var body: some View {
        TextField("\(deck.name)", text: $fileName)
        Button("Pick a folder to save in.") {
            isPresented.toggle()
        }
        .documentPicker(isPresented: $isPresented, types: [.folder], onDocumentPicked: { urls in
            saveDeck(urls.first)
        })
    }
    
    func saveDeck(_ folder: URL?) {
        print("Saving deck: \(deck.name) in \(fileName)")
        guard let url = folder else {
            return
        }
        if let encodedDeck = try? JSONEncoder().encode(deck) {
            let filePath: URL = url.appendingPathComponent(fileName, conformingTo: .json)
            do {
                try encodedDeck.write(to: filePath)
            } catch {
                fatalError("Failed to write deck: \(error.localizedDescription)")
            }
        } else {
            fatalError("Deck encoding failed.")
        }
    }
}

//#Preview {
//    SaveDeckView()
//}
