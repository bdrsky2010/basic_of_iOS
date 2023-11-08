//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Minjae Kim on 11/8/23.
//

import SwiftUI

struct DetailView: View {
	@Binding var scrum: DailyScrum
	
	@State private var editingScrum = DailyScrum.emptyScrum
	@State private var isPresentEditView: Bool = false
	
	var body: some View {
		List {
			Section {
				NavigationLink(destination: MeetingView()) {
					Label("Start Meeting", systemImage: "timer")
						.font(.headline)
						.foregroundStyle(scrum.theme.accentColor)
				}
				HStack {
					Label("Length", systemImage: "clock")
					Spacer()
					Text("\(scrum.lengthInMinutes) minutes")
				}
				.accessibilityElement(children: .combine)
				HStack {
					Label("Theme", systemImage: "paintpalette")
					Spacer()
					Text(scrum.theme.name)
						.padding(4)
						.foregroundStyle(scrum.theme.accentColor)
						.background(scrum.theme.mainColor)
						.clipShape(.rect(cornerRadius: 4))
				}
				.accessibilityElement(children: .combine)
			} header: {
				Text("Meeting Info")
			}
			Section {
				ForEach(scrum.attendees) { attendee in
					Label(attendee.name, systemImage: "person")
				}
			} header: {
				Text("Attendees")
			}
		}
		.navigationTitle(scrum.title)
		.toolbar {
			Button("Edit") {
				isPresentEditView = true
			}
		}
		.sheet(isPresented: $isPresentEditView) {
			NavigationStack {
				DetailEditView(scrum: $editingScrum)
					.navigationTitle(scrum.title)
					.toolbar {
						ToolbarItem(placement: .cancellationAction) {
							Button("Cancel") {
								isPresentEditView = false
							}
						}
						ToolbarItem(placement: .confirmationAction) {
							Button("Done") {
								isPresentEditView = false
								scrum = editingScrum
							}
						}
					}
			}
		}
	}
}

#Preview {
	NavigationStack {
		DetailView(scrum: .constant(DailyScrum.sampleData[0]))
	}
}
