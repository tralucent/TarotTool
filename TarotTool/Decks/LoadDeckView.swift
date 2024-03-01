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
    @State private var urls: [URL]?
    
    var body: some View {
        Button("Choose Deck to Load") {
            isPresented.toggle()
        }
        .fileImporter(isPresented: $isPresented, allowedContentTypes: [.json]) { result in
            switch result {
            case .success(let url):
                loadDeck(url)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
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
