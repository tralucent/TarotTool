//
//  EditCardView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/16/24.
//

import SwiftData
import SwiftUI

struct EditCardView: View {
    @Bindable var card: Card
    
    var body: some View {
        Form {
            Section {
                TextField("Card name", text: $card.name)
                TextField("Card details", text: $card.details, axis: .vertical)
            }
            
            Section("Notes") {
                TextField("Notes", text: $card.notes, axis: .vertical)
            }
        }
    }
}

//#Preview {
//    EditCardView()
//}
