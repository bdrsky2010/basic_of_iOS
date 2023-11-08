//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Minjae Kim on 11/6/23.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
	@State private var scrums = DailyScrum.sampleData
	
	var body: some Scene {
		WindowGroup {
			ScrumsView(scrums: $scrums)
		}
	}
}
