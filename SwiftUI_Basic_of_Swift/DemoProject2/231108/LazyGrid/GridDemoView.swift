//
//  GridDemoView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/8/23.
//

import SwiftUI

struct GridDemoView: View {
	private var colors: [Color] = [.blue, .yellow, .green]
	
//	flexible 모드는 디폴트로 생략가능
//	private var gridItems = [GridItem(),
//													 GridItem(.flexible()),
//													 GridItem(),
//	]
//	적응형 설정
//	뷰가 차지하는 공간에 맞출 수 있는 한 많은 행이나 열이 자동으로 표시되도록 그리드 뷰를 구성
//	열의 너비가 50pt 보다 작을 수 없다는 제한과 함께 그리드에 가능한 많은 열이 표시
//	private var gridItems = [GridItem(.adaptive(minimum: 50))]
//
//	고정형 설정
//	너비가 100pt 인 단일 열을 가진 그리드가 표시
//	private var gridItems = [GridItem(.fixed(100))]
//
//	고정형과 적응형의 조합
	private var gridItems = [GridItem(.fixed(150)),
							 GridItem(.flexible(minimum: 50)),
							 GridItem(.fixed(150)),
	]
//	private var gridItems: [GridItem] = [
//		GridItem(.flexible()),
//		GridItem(.flexible()),
//		GridItem(.flexible())
//	]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: gridItems, spacing: 5) {
				ForEach((0...29), id: \.self) { index in
					CellContent(index: index, color: colors[index % colors.count])
				}
			}
			.padding()
		}
	}
}

struct CellContent: View {
	var index: Int
	var color: Color
	
	var body: some View {
		Text("\(index)")
			.frame(minWidth: 75, minHeight: 50, maxHeight: .infinity)
			.background(color)
			.clipShape(.rect(cornerRadius: 8))
			.font(.largeTitle)
	}
}

#Preview {
	GridDemoView()
}
