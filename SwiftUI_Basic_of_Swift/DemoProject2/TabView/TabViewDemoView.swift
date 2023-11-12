//
//  TabViewDemoView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/9/23.
//
/**
 # TabView

 사용자가 이동할 화면들을 나타내는 하위 뷰들로 구성

 뷰들 사이들 이동하는 데 사용될 탭 아이템을 가진 탭 바를 레이아웃 하단에 표시
 
 탭 아이템에 태그 추가 (고유한 값을 갖는 태그를 할당)
 - 현재의 선택을 저장하기 위한 상태 프로퍼티를 선언
 - 상태 프로퍼티를 이용하여 역으로 탭 뷰 전환이 가능
 */
import SwiftUI

struct TabViewDemoView: View {
	@State private var selection: Int = 1
	
	var body: some View {
		
		Text("\(selection)")
		// TabView 콘텐트 추가
		TabView(selection: $selection) {
			
			Text("First Content view")
				.tabItem {
					Image(systemName: "1.circle")
					Text("Screen One")
				}
				.tag(1)
			
			Text("Second Content view")
				.tabItem {
					Image(systemName: "2.circle")
					Text("Screen Tow")
				}
				.tag(2)
			
			Text("Third Content view")
				.tabItem {
					Image(systemName: "3.circle")
					Text("Screen Three")
				}
				.tag(3)
		}
		.font(.largeTitle)
		// 뷰 페이징
		// 탭 아이템 추가시 시각적 표시 제공을 위해 tabViewStyle() 수정자를 제거
		// tabItem() 수정자를 사용하여 각 콘텐트 뷰에 탭 아이템을 적용
		.tabViewStyle(PageTabViewStyle())
		.background(.teal)
	}
}

#Preview {
	TabViewDemoView()
}
