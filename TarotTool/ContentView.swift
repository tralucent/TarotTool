//
//  ContentView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 12/1/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    
    @State private var sortOrder = [SortDescriptor(\Reading.name)]
    @State private var searchText = ""
    @State private var currentTab: Int = 2
    
    @State private var cardOrder = [SortDescriptor(\Card.name)]
    @State private var deckOrder = [SortDescriptor(\Deck.name)]

    @Query(sort: [
        SortDescriptor(\Deck.name)
    ]) var deckList: [Deck]
    @State private var selectedDeck: Deck? = nil

    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $currentTab) {
                DeckListView(searchString: searchText, sortOrder: deckOrder)
                    .tabItem {
                        Label("Decks", systemImage: "square.stack.3d.up")
                    }
                    .tag(1)
                ReadingsView(searchString: searchText, sortOrder: sortOrder)
                    .tabItem {
                        Label("Readings", systemImage: "book.pages")
                    }
                    .tag(2)
                CardsView(deck: selectedDeck, searchString: searchText, sortOrder: cardOrder)
                    .tabItem {
                        Label("Cards", systemImage: "square.stack")
                    }
                    .tag(3)
            }
            .navigationTitle("TarotTool")
            .navigationDestination(for: Reading.self) { reading in
                EditReadingView(reading: reading, navigationPath: $path)
            }
            .navigationDestination(for: Card.self) { card in
                EditCardView(card: card)
            }
            .navigationDestination(for: Deck.self) { deck in
                EditDeckView(deck: deck, navigationPath: $path)
            }
            .navigationDestination(for: Spread.self) { spread in
                EditSpreadView(spread: spread)
            }
            .toolbar {
                if currentTab == 1 {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $deckOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Deck.name)])
                            
                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Deck.name, order: .reverse)])
                        }
                    }
                } else if currentTab == 2 {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Reading.name)])
                            
                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Reading.name, order: .reverse)])
                        }
                    }
                } else if currentTab == 3 {
                    Menu("Select a deck", systemImage: "line.3.horizontal.decrease") {
                        Picker("Select a deck", selection: $selectedDeck) {
                            Text("None")
                                .tag(nil as Deck?)
                            ForEach(deckList) { deck in
                                Text(deck.name)
                                    .tag(deck as Deck?)
                            }
                        }
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $cardOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Card.name)])
                            
                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Card.name, order: .reverse)])
                        }
                    }
                }
                
                // this is a for now addition to make it easy to delete all decks and cards
                Button("Clean up", systemImage: "trash") {
                    deleteAllDecksAndCards()
                }

                Menu("Add things", systemImage: "plus") {
                    Button("Add Reading", action: addReading)
                    Button("Add Deck", action: addDeck)
                    Button("Add Card", action: addCard)
                    Button("Add Spread", action: addSpread)
                }
            }
            .searchable(text: $searchText)
        }
    }
    
    // this clears all decks and cards
    func deleteAllDecksAndCards() {
        do {
            try modelContext.delete(model: Deck.self)
            try modelContext.delete(model: Card.self)
        } catch {
            print("Could not delete data")
        }
    }
    
    func addReading() {
        let reading = Reading(name: "", spread: nil, query: "", deck: [], cards: [], highlights: "", notes: "")
        modelContext.insert(reading)
        path.append(reading)
    }
    
    func addDeck() {
        let deck = Deck(name: "", author: "", artist: "", details: "", history: "", notes: "", cards: [], image: nil, cardBack: nil)
        modelContext.insert(deck)
        path.append(deck)
    }
    
    func addCard() {
        let card = Card(name: "", type: nil, order: -1, details: "", notes: "", history: "", meaning: "", associations: "", deck: nil, readings: [], image: nil)
        modelContext.insert(card)
        path.append(card)
    }
    
    func addSpread() {
        let spread = Spread(name: "", details: "", notes: "", numberOfCards: 1, history: "", image: nil)
        modelContext.insert(spread)
        path.append(spread)
    }
}

#Preview {
    ContentView()
}
