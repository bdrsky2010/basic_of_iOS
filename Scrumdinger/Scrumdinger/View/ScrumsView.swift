//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Minjae Kim on 11/6/23.
//

import SwiftUI

struct ScrumsView: View {
	@Binding var scrums: [DailyScrum]
	
	var body: some View {
		NavigationStack {
			List($scrums) { $scrum in
				NavigationLink(destination: DetailView(scrum: $scrum)) {
					CardView(scrum: scrum)
						.listRowBackground(scrum.theme.mainColor)
				}
			}
			.navigationTitle("Daily Scrums")
			.toolbar {
				Button(action: {}) {
					Image(systemName: "plus")
				}
				.accessibilityLabel("New Scrum")
			}
		}
	}
}

#Preview {
	ScrumsView(scrums: .constant(DailyScrum.sampleData))
}
