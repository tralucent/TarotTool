//
//  EditSpreadView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/27/24.
//

import SwiftData
import SwiftUI

struct EditSpreadView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var spread: Spread
    
    var body: some View {
        Form {
            Section {
                TextField("Spread name", text: $spread.name)
                TextField("Details", text: $spread.details)
            }
            Section {
                TextField("Notes", text: $spread.notes)
            }
        }
    }
}

//#Preview {
//    EditSpreadView()
//}
