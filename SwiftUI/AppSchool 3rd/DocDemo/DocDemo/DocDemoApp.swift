//
//  DocDemoApp.swift
//  DocDemo
//
//  Created by Minjae Kim on 12/26/23.
//

import SwiftUI

@main
struct DocDemoApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: DocDemoDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
