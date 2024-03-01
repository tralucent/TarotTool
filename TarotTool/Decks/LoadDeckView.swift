//
//  LoadDeckView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 2/28/24.
//

import SwiftUI

struct LoadDeckView: View {
    @Environment(\.modelContext) var modelContext
    @State private var isPresented = false
    
    var body: some View {
        Button("Choose Deck to Load") {
            isPresented.toggle()
        }
        .documentPicker(isPresented: $isPresented, types: [.json], onDocumentPicked: { urls in
            loadDeck(urls.first!)
        })
    }
    
    func loadDeck(_ url: URL) {
        print("Loading Deck at: \(url.absoluteString)")
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load data from \(url.absoluteString)")
        }
        
        let decoder = JSONDecoder()
        
        do {
            let deck = try decoder.decode(Deck.self, from: data)
            modelContext.insert(deck)
        } catch {
            print("Error decoding deck: \(error.localizedDescription)")
        }
    }
}

#Preview {
    LoadDeckView()
}
