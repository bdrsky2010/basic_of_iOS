
/*
 p.259
 보일 때, 감추어 질 때
 
 - onAppear()   : 뷰가 나타날 때 호출
 - onDisappear(): 뷰가 사라질 때 호출
 */

import SwiftUI

struct FirstTabView: View {
	
	@State var title = "View One"
	@State var isTitleView: Bool = false
	
	var body: some View {
		Text(title)
			.onAppear(perform: {
				print("onAppear triggered First")
			})
			.onDisappear(perform: {
				print("onDisappear triggered First")
			})
			.task(priority: TaskPriority.background) {
				title = await changeTitle()
				isTitleView = await enableTitleView()
			}
		
		if isTitleView {
			Text("금요일같은 목요일")
				.font(.largeTitle)
		}
	}
	
	func enableTitleView() async -> Bool {
		sleep(5)
		return true
	}
	
	func changeTitle() async -> String {
		sleep(5)
		return "비동기 처리 완료"
	}
}

#Preview {
	FirstTabView()
}
