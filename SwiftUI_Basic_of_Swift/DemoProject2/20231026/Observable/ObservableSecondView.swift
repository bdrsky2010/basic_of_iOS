//
//  ObservableSecondView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct ObservableSecondView: View {
	
	@EnvironmentObject var timerData: TimerData
	
	var body: some View {
		VStack {
			Text("Second View")
				.font(.largeTitle)
			Text("Timer Count = \(timerData.timeCount)")
				.font(.largeTitle)
		}
	}
}

#Preview {
	ObservableSecondView().environmentObject(TimerData())
}
