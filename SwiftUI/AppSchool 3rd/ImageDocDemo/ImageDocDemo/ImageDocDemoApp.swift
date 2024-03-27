//
//  ImageDocDemoApp.swift
//  ImageDocDemo
//
//  Created by Minjae Kim on 12/26/23.
//

import SwiftUI

@main
struct ImageDocDemoApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ImageDocDemoDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
