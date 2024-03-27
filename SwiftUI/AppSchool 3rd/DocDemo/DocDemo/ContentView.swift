//
//  ContentView.swift
//  DocDemo
//
//  Created by Minjae Kim on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: DocDemoDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(DocDemoDocument()))
}
