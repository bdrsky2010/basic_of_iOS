//
//  MidFcstinfoServiceView.swift
//  SwiftAPIDemo
//
//  Created by Minjae Kim on 12/4/23.
//

import SwiftUI

struct MidFcstinfoServiceView: View {
	
	@StateObject var network = MidFcstInfoServiceAPI.shared
	
	var body: some View {
		NavigationStack {
			List {
				Text(network.resultMessage ?? "")
				ForEach(network.posts, id: \.self) { result in
					HStack {
						Text(result.wfSv)
							.bold()
					}
					.padding(5)
				}
			}.navigationTitle("Weather")
		}
		.onAppear() {
			network.feachData()
		}
	}
}

#Preview {
	MidFcstinfoServiceView()
}
