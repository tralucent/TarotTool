//
//  TarotToolApp.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 12/1/23.
//

import SwiftData
import SwiftUI

@main
struct TarotToolApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Reading.self)
    }
}
