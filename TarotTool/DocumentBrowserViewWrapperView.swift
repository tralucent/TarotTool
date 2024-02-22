//
//  DocumentBrowserViewWrapperView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 2/22/24.
//

import SwiftUI

struct DocumentBrowserViewWrapperView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedFileURL: URL?
    
    var body: some View {
        VStack {
            DocumentBrowserView(selectedFileURL: $selectedFileURL)
                .navigationBarTitle("Document Browser")
            
            if let fileURL = selectedFileURL {
                Text("Selected File: \(fileURL.lastPathComponent)")
            }
            
            Button("Dimiss") {
                dismiss()
            }
        }
        .padding()
    }
}

//#Preview {
//    DocumentBrowserViewWrapperView()
//}
