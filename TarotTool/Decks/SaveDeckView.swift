//
//  SaveDeckView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 2/28/24.
//

import SwiftUI

struct SaveDeckView: View {
    @State private var isPresented = false
    @State private var fileName: String = ""
    var deck: Deck
    
    var body: some View {
        TextField("File name", text: $fileName)
        Button("Choose folder") {
            isPresented.toggle()
        }
//        .fileExporter(isPresented: $isPresented, documents: Deck, contentType: .json, onCompletion: { result in
//            switch result {
//            case .success(let urls):
//                print(urls.first?.absoluteString)
//            case .failure(let error):
//                print("An error: \(error.localizedDescription)")
//            }
//        })
//        
        .fileImporter(isPresented: $isPresented, allowedContentTypes: [.folder]) { result in
            switch result {
            case .success(let url):
                saveDeck(url)
            case .failure(let error):
                print("An error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveDeck(_ folder: URL?) {
        print("Saving deck: \(deck.name) in \(fileName)")
        guard let url = folder else {
            return
        }
        
        if fileName.isEmpty {
            print("No filename provided, deck not saved")
            return
        }
        
        if let encodedDeck = try? JSONEncoder().encode(deck) {
            let filePath: URL = url.appendingPathComponent(fileName, conformingTo: .json)
            do {
                try encodedDeck.write(to: filePath)
            } catch {
                fatalError("Failed to write deck: \(error.localizedDescription)")
            }
        } else {
            fatalError("Deck encoding failed.")
        }
    }
}

//#Preview {
//    SaveDeckView()
//}
