//
//  GoogleFormsMainView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//

import SwiftUI

struct GoogleFormsMainView: View {
	@State private var stackPath: NavigationPath = NavigationPath()
	let index = 1
	var body: some View {
		NavigationStack(path: $stackPath) {
			Form {
				Section {
					AppSchoolImageView()
				}
				
				Section {
					VStack(alignment: .leading) {
						Text("7&8주차 설문")
							.font(.title)
						Text("""
안녕하세요 수강생 여러분 : )
이번 주도 고생 많으셨습니다 🥰
테킷 앱 스쿨 : iOS 3기 에서는 매 주의 주간 설문을 통해 여러분의 학습 상황을 파악하고,
이를 통해 여러분의 성장을 보다 효과적으로 지원하기 위한 활동을 하고 있습니다.

여러분들이 작성해주신 자세한 의견을 반영하여 더욱 성장하실 수 있는 환경을 제공하고자 합니다.
이번 주차 활동을 회고하면서 솔직하게 작성하시되 매너 있는 톤으로 부탁 드립니다.

(강사님과의 소통하며 여러분들의 의사가 반영 될 수 있도록 노력하고 있으니 많은 참여 부탁 드리겠습니다. ☀️)
""")
					}
					
					VStack(alignment: .leading) {
						HStack {
							Text("qorhaqt@gmail.com")
							Button("계정전환") { }
						}
						Spacer()
						Text("파일을 업로드하고 이 양식을 제출하면 Google 계정과 연결된 이름 및 사진이 기록됩니다.. 이메일 주소가 응답에 포함되지 않습니다.")
					}
				}
				Section {
					HStack {
						NavigationLink(destination: FirstFormsPageView(stackPath: $stackPath)) {
							Text("다음")
						}
						
						Spacer()
						
						FormProgressView(value: index)
						
						Spacer()
						
						Button {
							
						} label: {
							Text("양식 지우기")
						}
						.buttonStyle(.borderless)
					}
				}
			}
		}
	}
}

#Preview {
	GoogleFormsMainView()
}
