//
//  EditDeckView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/27/24.
//

import SwiftData
import SwiftUI

struct EditDeckView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var deck: Deck
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $deck.name)
                TextField("Author", text: $deck.author)
                TextField("Artist", text: $deck.artist)
            }
            Section {
                TextField("Notes", text: $deck.notes)
            }
        }
    }
}

//#Preview {
//    EditDeckView()
//}
