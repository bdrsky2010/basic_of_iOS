//
//  AlignmentView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/30/23.
//

import SwiftUI

struct AlignmentView: View {
	var body: some View {
		VStack(spacing: 50) {
			// 컨테이너 정렬 VStack
			VStack(alignment: .trailing) {
				Text("This is some text")
				Text("This is some longer text")
				Text("This is short")
			}
			
			// 컨테이너 정렬 HStack
			HStack(alignment: .lastTextBaseline, spacing: 20) {
				Text("This is some text")
					.font(.largeTitle)
				Text("This is some longer text")
					.font(.body)
				Text("This is short")
					.font(.headline)
			}
			
			// 정렬 가이드 p.285
			VStack(alignment: .leading) {
				Rectangle()
					.foregroundStyle(.green)
					.frame(width: 120, height: 50)
				Rectangle()
					.foregroundStyle(.red)
					.frame(width: 120, height: 50)
				Rectangle()
					.foregroundStyle(.blue)
					.frame(width: 120, height: 50)
					.alignmentGuide(.leading, computeValue: { d in d.width / 3 })
				
				// HorizontalAlignment, VerticalAlignment 프로퍼티에 접근
				Rectangle()
					.foregroundStyle(.yellow)
					.frame(width: 120, height: 50)
					.alignmentGuide(.leading, computeValue: { d in d[HorizontalAlignment.trailing] })
			}
		}
	}
}

#Preview {
	AlignmentView()
}
