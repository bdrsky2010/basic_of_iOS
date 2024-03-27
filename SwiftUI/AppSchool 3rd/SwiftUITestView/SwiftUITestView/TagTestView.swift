//
//  TagTestView.swift
//  SwiftUITestView
//
//  Created by Minjae Kim on 1/31/24.
//

import SwiftUI

struct TagTestView: View {
	private let tags = ["대방어", "새우튀김", "광어", "우럭", "이거 한 줄에 몇개 넣어야 할까?", "정렬 문제도", "뭘까", "짬뽕", "짜장", "탕수육", "팔보채", "치킨", "피자", "족발", "콜라", "사이다", "맥콜", "데자와"]
	var body: some View {
		GeometryReader { geometryProxy in
			FlexibleView(
				availableWidth: geometryProxy.size.width, data: tags,
				spacing: 15,
				alignment: .leading
			) { item in
				Text(item)
					.padding(8)
					.background(
						RoundedRectangle(cornerRadius: 8)
							.fill(Color.gray.opacity(0.2))
					)
			}
			.padding(.horizontal, 10)
		}
	}
}

#Preview {
	TagTestView()
}

extension View {
	func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
		background(
		  GeometryReader { geometryProxy in
			Color.clear
			  .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
		  }
		)
		.onPreferenceChange(SizePreferenceKey.self, perform: onChange)
	}
}

private struct SizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
	let availableWidth: CGFloat
	let data: Data
	let spacing: CGFloat
	let alignment: HorizontalAlignment
	let content: (Data.Element) -> Content
	@State var elementsSize: [Data.Element: CGSize] = [:]
	
	var body : some View {
		VStack(alignment: alignment, spacing: spacing) {
			ForEach(computeRows(), id: \.self) { rowElements in
				HStack(spacing: spacing) {
					ForEach(rowElements, id: \.self) { element in
						content(element)
							.fixedSize()
							.readSize { size in
								elementsSize[element] = size
							}
					}
				}
			}
		}
	}
	
	func computeRows() -> [[Data.Element]] {
		var rows: [[Data.Element]] = [[]]
		var currentRow = 0
		var remainingWidth = availableWidth
		
		for element in data {
			let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
			
			if remainingWidth - (elementSize.width + spacing) >= 0 {
				rows[currentRow].append(element)
			} else {
				currentRow = currentRow + 1
				rows.append([element])
				remainingWidth = availableWidth
			}
			
			remainingWidth = remainingWidth - (elementSize.width + spacing)
		}
		
		return rows
	}
}
