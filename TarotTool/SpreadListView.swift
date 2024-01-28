//
//  SpreadListView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/27/24.
//

import SwiftData
import SwiftUI

struct SpreadListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var spreads: [Spread]
    
    var body: some View {
        List {
            ForEach(spreads) { spread in
                Text(spread.name)
            }
        }
    }
}

#Preview {
    SpreadListView()
}
