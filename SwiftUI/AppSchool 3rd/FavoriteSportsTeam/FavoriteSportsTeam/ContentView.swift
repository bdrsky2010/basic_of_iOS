//
//  ContentView.swift
//  FavoriteSportsTeam
//
//  Created by Minjae Kim on 11/27/23.
//

import SwiftUI

struct Schedule: Identifiable, Hashable {
	let id = UUID()
	let date: String
	let homeImage: String
	let homeTeam: String
	let isProgress: Bool
	let awayImage: String
	let awayTeam: String
}

struct ContentView: View {
	let tottenhams: [String] = ["tottenham.1", "tottenham.2", "tottenham.3"]
	let items: [String] = ["uniform.1", "uniform.2", "uniform.3", "teddy"]
	let issues: [String] = ["SON 세 차례나 골망 흔들었지만…현지서도 ‘오프사이드 불운’ 조명", "SON ‘오프사이드 불운’ 연속 속 침묵…토트넘, 빌라에 1-2 역전패 ‘3연패 수렁’", "토트넘, 마네·홀란 잇는 ‘특급 재능’ 노린다...빅 클럽과 경쟁 예상"]
	let schedules: [Schedule] = [
		Schedule(date: "12.04 월 (01:30)", homeImage: "mancityLogo", homeTeam: "맨시티", isProgress: false, awayImage: "tottenhamLogo", awayTeam: "토트넘"),
		Schedule(date: "12.08 금 (05:15)", homeImage: "tottenhamLogo", homeTeam: "토트넘", isProgress: false, awayImage: "westHamLogo", awayTeam: "웨스트햄"),
		Schedule(date: "12.11 월 (05:00)", homeImage: "tottenhamLogo", homeTeam: "토트넘", isProgress: false, awayImage: "newcastleLogo", awayTeam: "뉴캐슬"),
		Schedule(date: "12.24 일 (00:00)", homeImage: "forestLogo", homeTeam: "노팅엄 포레스트", isProgress: false, awayImage: "tottenhamLogo", awayTeam: "토트넘")
	]
	
	var body: some View {
		NavigationStack {
			GeometryReader { geo in
				VStack {
					TabView {
						ForEach(tottenhams, id: \.self) { imageName in
							Image(imageName, bundle: nil)
								.resizable()
								.frame(width: geo.size.width / 10 * 9)
								.clipShape(.rect(cornerRadius: 15))
						}
					}
					.tabViewStyle(.page)
					
					VStack {
						HStack {
							Text("굿즈")
							Spacer()
							NavigationLink {
								Text("굿즈")
							} label: {
								Text("더보기")
							}
						}
						.font(.title3)
						
						Divider()
						
						ScrollView(.horizontal, showsIndicators: false) {
							HStack {
								ForEach(items, id: \.self) { item in
									Image(item, bundle: nil)
										.resizable()
										.frame(width: 120, height: 120)
										.clipShape(.rect(cornerRadius: 15))
								}
							}
						}
						.padding(.vertical)
						
						HStack {
							Text("주요 뉴스")
							Spacer()
							NavigationLink {
								Text("주요 뉴스")
							} label: {
								Text("더보기")
							}
						}
						.font(.title3)
						
						Divider()
						
						VStack(alignment: .leading, spacing: 10) {
							ForEach(issues, id: \.self) { issue in
								Text(issue)
							}
						}
						.font(.caption)
						.padding(.vertical)
						
						HStack {
							Text("경기 일정")
							Spacer()
							NavigationLink {
								Text("경기 일정")
							} label: {
								Text("더보기")
							}
						}
						.font(.title3)
						
						Divider()
						
						VStack {
							ForEach(schedules, id: \.self) { schedule in
								HStack {
									Text(schedule.date)
									Image(schedule.homeImage, bundle: nil)
										.resizable()
										.frame(width: 20, height: 20)
									
									Text(schedule.homeTeam)
									Spacer()
									Text(schedule.isProgress ? "경기후" : "경기전")
									Spacer()
									Image(schedule.awayImage, bundle: nil)
										.resizable()
										.frame(width: 20, height: 20)
									
									Text(schedule.awayTeam)
								}
								.font(.caption)
							}
						}
						.padding(.vertical)
					}
					.padding(.vertical)
					.frame(width: geo.size.width / 10 * 9)
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
