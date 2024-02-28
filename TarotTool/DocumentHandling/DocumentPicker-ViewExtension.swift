//
//  DocumentPicker-ViewExtension.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 2/28/24.
//

import SwiftUI
import UniformTypeIdentifiers.UTType

public extension View {
    func documentPicker(
        isPresented: Binding<Bool>,
        types: [UTType] = [],
        onCancel: @escaping () -> () = { }, onDocumentPicked: @escaping (_: [URL]) -> () = {_ in }
    ) -> some View {
        Group {
            self
            DocumentPicker(isPresented: isPresented, types: types, onCancel: onCancel, onDocumentsPicked: onDocumentPicked)
        }
    }
}
