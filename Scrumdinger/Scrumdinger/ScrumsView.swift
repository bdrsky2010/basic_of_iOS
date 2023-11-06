//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Minjae Kim on 11/6/23.
//

import SwiftUI

struct ScrumsView: View {
	let scrums: [DailyScrum]
	
	var body: some View {
		List(scrums, id: \.title) { scrum in
			CardView(scrum: scrum)
				.listRowBackground(scrum.theme.mainColor)
		}
	}
}

#Preview {
	ScrumsView(scrums: DailyScrum.sampleData)
}
