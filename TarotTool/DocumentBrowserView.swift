//
//  DocumentBrowserView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 2/21/24.
//

import SwiftUI
import UIKit

struct DocumentBrowserView: UIViewControllerRepresentable {
    @Binding var selectedFileURL: URL?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIDocumentBrowserViewController {
        let documentBrowser = UIDocumentBrowserViewController(forOpening: [.pdf, .text, .json, .jpeg, .png])
        documentBrowser.delegate = context.coordinator
        documentBrowser.allowsDocumentCreation = false
        return documentBrowser
    }

    func updateUIViewController(_ uiViewController: UIDocumentBrowserViewController, context: Context) {
        // Update the view controller if needed
    }
    
    func didRequestDocumentCreationWithHandler() {
        // this is needed? i'm getting a runtime warning that i hope this will stop.
    }

    class Coordinator: NSObject, UIDocumentBrowserViewControllerDelegate {
        var parent: DocumentBrowserView

        init(parent: DocumentBrowserView) {
            self.parent = parent
        }

        func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
            if let selectedURL = documentURLs.first {
                parent.selectedFileURL = selectedURL
            }
        }
    }
}

//#Preview {
//    DocumentBrowserView()
//}
