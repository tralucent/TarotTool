//
//  DocumentPicker.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 2/28/24.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers.UTType

struct DocumentPicker: UIViewControllerRepresentable {
    
    class Coordinator: NSObject {
        var parent: DocumentPicker
        var pickerController: UIDocumentPickerViewController
        var presented = false
        
        init(_ parent: DocumentPicker, types: [UTType], asCopy: Bool = false) {
            self.parent = parent
            self.pickerController = UIDocumentPickerViewController(forOpeningContentTypes: types, asCopy: asCopy)
            
//            self.pickerController.allowsMultipleSelection = true
//            self.pickerController.directoryURL = URL()
            
            super.init()
            pickerController.delegate = self
        }
    }
    
    @Binding var isPresented: Bool
    var types: [UTType]
    var onCancel: () -> ()
    var onDocumentsPicked: (_: [URL]) -> ()
    
    init(isPresented: Binding<Bool>, types: [UTType], onCancel: @escaping () -> Void, onDocumentsPicked: @escaping (_: [URL]) -> Void) {
        self._isPresented = isPresented
        self.types = types
        self.onCancel = onCancel
        self.onDocumentsPicked = onDocumentsPicked
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ presentingController: UIViewControllerType, context: Context) {
        let pickerController = context.coordinator.pickerController
        if isPresented && !context.coordinator.presented {
            context.coordinator.presented.toggle()
            presentingController.present(pickerController, animated: true)
        } else if !isPresented && context.coordinator.presented {
            context.coordinator.presented.toggle()
            presentingController.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, types: types)
    }
}

extension DocumentPicker.Coordinator: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        parent.isPresented.toggle()
        parent.onDocumentsPicked(urls)
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        parent.isPresented.toggle()
        parent.onCancel()
    }
}

struct DocumentPicker_Previewer: PreviewProvider {
    static var previews: some View {
        Text("Document Picker")
            .documentPicker(
                isPresented: .constant(true),
                types: [.json, .folder])
    }
}
