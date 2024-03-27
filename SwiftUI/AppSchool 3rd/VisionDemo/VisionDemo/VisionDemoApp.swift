//
//  VisionDemoApp.swift
//  VisionDemo
//
//  Created by Minjae Kim on 1/11/24.
//

import SwiftUI

@main
struct VisionDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
