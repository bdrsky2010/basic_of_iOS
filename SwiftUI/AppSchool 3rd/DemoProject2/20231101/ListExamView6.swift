//
//  ListExamView6.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/1/23.
//

import SwiftUI

struct ListExamView6: View {
	
	struct Sport: Identifiable {
		let id: UUID = UUID()
		let image: String
		let sports: String
	}
	
	private let sports: [Sport] = [
		Sport(image: "soccerball", sports: "Soccer"),
		Sport(image: "baseball", sports: "Baseball"),
		Sport(image: "basketball.fill", sports: "Basketball"),
		Sport(image: "football.fill", sports: "Football"),
		Sport(image: "tennisball.fill", sports: "Tennis"),
		Sport(image: "snowboard.fill", sports: "Snowboard")
	]
	
	@State private var multiSelection: Set<UUID> = Set<UUID>()
	
	var body: some View {
		List(sports, selection: $multiSelection) { sport in
			HStack {
				Image(systemName: sport.image)
				Text(sport.sports)
			}
		}
		.toolbar { EditButton() }
		.navigationTitle("SwiftUI List Quiz")
	}
}

#Preview {
	ListExamView6()
}
