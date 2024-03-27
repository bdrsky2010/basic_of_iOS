// - VStack(수직), HStack(수평), ZStack(중첩되게 배치하는 뷰)
// p.194 Spacer(), aligment, padding()
// - 뷰 사이에 공간을 추가(스택의 방향에 따라 유연하게 확장/축소): Spacer()
// - 스택 정렬과 간격: HStack(alignment: .top, spacing: 15)
// - 뷰 주변의 간격: .padding(.horizontal, 20)

import SwiftUI

struct StackFrameView: View {
	@State var myLayout: AnyLayout = AnyLayout(VStackLayout())
	var body: some View {
		VStack {
			
			myLayout {
				Image(systemName: "goforward.10")
				Image(systemName: "goforward.15")
				Image(systemName: "goforward.30")
			}
			HStack {
				Button("HStack") { myLayout = AnyLayout(HStackLayout()) }
				Button("VStack") { myLayout = AnyLayout(VStackLayout()) }
			}
			
			Spacer()
			// 수평
			HStack {
				Image(systemName: "goforward.10")
				Image(systemName: "goforward.15")
				Image(systemName: "goforward.30")
			}
			Spacer() // 뷰 사이에 공간을 추가
			
			// 수직
			VStack {
				Image(systemName: "goforward.10")
				Image(systemName: "goforward.15")
				Image(systemName: "goforward.30")
			}
			Spacer()
			Text("Hello, world")
				.padding([.horizontal], 20) // padding() 뷰 주변의 간격
				.border(Color.black)
			
			HStack(alignment: .top, spacing: 150) {
				Text("Q====")
					.border(Color.black)
				VStack {
					Text("Q1")
					Text("Q2")
					Text("Q3")
				}
				.border(Color.black)
			}
			.border(Color.black)
		}
		
		// 텍스트 줄 제한과 레이아웃 우선순위
		HStack {
			Image(systemName: "airplane")
			Text("Flight time:")
				.layoutPriority(1)
			Text("London")
			Text("Seoul")
				.layoutPriority(2)
			Text("Paris")
		}
		.font(.largeTitle)
		.lineLimit(1...2)
		
		Text("SwiftUI Frame")
			.font(.largeTitle)
			.border(Color.black)
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		
		// 뷰들을 담고 있는 컨테이너의 크기에 따라 조절
		// frame과 GeometryReader
		GeometryReader { geometry in
			// VStack의 1/2폭과 3/4 높이를 차지
			VStack {
				Text("GeometryReader")
					.font(.largeTitle)
					.border(Color.black)
					.frame(width: geometry.size.width / 2, height: geometry.size.height / 4 * 3)
				
				// VStack의 1/3폭과 1/4 높이를 차지
				Text("Goodbye World..")
					.font(.largeTitle)
					.border(Color.black)
					.frame(width: geometry.size.width / 3, height: geometry.size.height / 4)
			}
		}
	}
}

#Preview {
	StackFrameView()
}
