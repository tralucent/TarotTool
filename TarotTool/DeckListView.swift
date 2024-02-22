//
//  DeckListView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/27/24.
//

import SwiftData
import SwiftUI

struct DeckListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var decks: [Deck]
    
    @State private var selectedFileURL: URL?
    @State private var showingFileBrowser = false
    
    var body: some View {
        VStack {
            List {
                ForEach(decks) { deck in
                    NavigationLink(value: deck) {
                        Text(deck.name)
                    }
                }
                .onDelete(perform: deleteDecks)
            }
            VStack {
                Button("Select Deck") {
                    showingFileBrowser.toggle()
                }
                .sheet(isPresented: $showingFileBrowser, content: {
                    DocumentBrowserViewWrapperView(selectedFileURL: $selectedFileURL)
                        .navigationBarTitle("Document Browser")
                })
                
                Button("Load a Deck") {
                    Task {
                        await loadDeck()
                    }
                }
            }
            .padding()
        }
    }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Deck>] = []) {
        _decks = Query(filter: #Predicate { deck in
            if searchString.isEmpty {
                true
            } else {
                deck.name.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    func loadDeck() async {
        //loading happens here
        print("you hit the button!")
        
//        guard let url = URL(string: "https://drive.google.com/file/d/1ouquJJT8xNp7E6DzdOfngWxAPG-k41jB/view?usp=drive_link") else {
//            fatalError("Invalide url")
//        }
        
        let url = URL.documentsDirectory.appending(path: "White Numen.json")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
                
        do {
            // try things
            //let (data, _) = try await URLSession.shared.data(from: url)
            let data = try Data(contentsOf: url)
            
            //try print(decoder.decode(Deck.self, from: data))
            
            guard let decodedDeck = try? decoder.decode(Deck.self, from: data) else {
                fatalError("Failed to decode deck")
            }
            
            modelContext.insert(decodedDeck)
            //path.append(decodedDeck)
        } catch {
            print("Decoding failed: \(error.localizedDescription)")
        }
    }
    
    func deleteDecks(at offsets: IndexSet) {
        for offset in offsets {
            let deck = decks[offset]
            modelContext.delete(deck)
        }
    }
}

#Preview {
    DeckListView()
}
