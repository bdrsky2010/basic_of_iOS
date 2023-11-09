//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Minjae Kim on 11/9/23.
//

import SwiftUI

struct MeetingHeaderView: View {
	let secondsElapsed: Int
	let secondsRemaing: Int
	let theme: Theme
	
	private var totalSeconds: Int {
		secondsElapsed + secondsRemaing
	}
	private var progress: Double {
		guard totalSeconds > 0 else { return 1 }
		return Double(secondsElapsed) / Double(secondsRemaing)
	}
	private var minutesRemaining: Int {
		secondsRemaing / 60
	}
	var body: some View {
		VStack {
			ProgressView(value: progress)
				.progressViewStyle(ScrumProgressViewStyle(theme: theme))
			HStack {
				VStack(alignment: .leading) {
					Text("Sceonds Elapsed")
						.font(.caption)
					Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
				}
				Spacer()
				VStack(alignment: .trailing) {
					Text("Seconds Remaining")
						.font(.caption)
					Label("\(secondsRemaing)", systemImage: "hourglass.tophalf.fill")
						.labelStyle(.trailingIcon)
				}
			}
		}
		.accessibilityElement(children: .ignore)
		.accessibilityLabel("Time remaining")
		.accessibilityValue("10 minutes")
		.padding([.top, .horizontal])
	}
}

#Preview {
	MeetingHeaderView(secondsElapsed: 60, secondsRemaing: 100, theme: .bubblegum)
		.previewLayout(.sizeThatFits)
}
