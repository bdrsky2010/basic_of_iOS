//
//  ContentView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/10/23.
//

import SwiftUI

struct ContentView: View {
	
	var body: some View {
		NavigationView {
			List {
				Section("Caffeine S2") {
					NavigationLink(destination: CaffeineS2()) { Text("팀 노션") }
				}
				
				Section("2023년 10월 10일") {
					NavigationLink(destination: Calculator()) { Text("사칙연산") }
					NavigationLink(destination: Tangerine()) { Text("귤") }
					NavigationLink(destination: Mandarine()) { Text("다른 귤") }
					NavigationLink(destination: RoundDown()) { Text("버림") }
					NavigationLink(destination: OneChange()) { Text("1의자리") }
					NavigationLink(destination: SubjectAvg()) { Text("과목평균") }
				}
				
				Section("2023년 10월 11일") {
					NavigationLink(destination: Practice_1011()) { Text("연습") }
					NavigationLink(destination: DateCalc()) { Text("시간계산기") }
					NavigationLink(destination: WageCalc()) { Text("시급계산기") }
				}
				
				Section("2023년 10월 12일") {
					NavigationLink(destination: StackFrameView()) { Text("StackFrameView") }
				}
				
				Section("2023년 10월 13일") {
					NavigationLink(destination: StateView()) { Text("StateView") }
					NavigationLink(destination: RotateText()) { Text("RotateText") }
				}
				
				Section("2023년 10월 16일") {
					NavigationLink(destination: ImageExample()) { Text("ImageView") }
					NavigationLink(destination: CountExample()) { Text("CountView") }
					NavigationLink(destination: AlignExample()) { Text("AlignView") }
				}
				
				Section("2023년 10월 19일") {
					NavigationLink(destination: ConcurrencyListView()) { Text("ConcurrencyView") }
				}
				
				Section("2023년 10월 26일") {
					NavigationLink(destination: LifeCycleDemoView()) { Text("LifeCycleDemoView") }
					NavigationLink(destination: ObservableDemoView()) { Text("ObservableDemoView") }
					NavigationLink(destination: StorageDemoView()) { Text("StorageDemoView") }
				}
			}
			.navigationTitle("예제")
		}
	}
}

#Preview {
	ContentView()
}
