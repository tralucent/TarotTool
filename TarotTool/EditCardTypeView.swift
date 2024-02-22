//
//  EditCardTypeView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 2/8/24.
//

import SwiftData
import SwiftUI

struct EditCardTypeView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var card: Card
    
    var body: some View {
        Form {
            
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return EditCardTypeView(card: previewer.card)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
