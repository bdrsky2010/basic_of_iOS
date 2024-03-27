//
//  AlignmentZStackView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/30/23.
//

import SwiftUI

// p.292
extension VerticalAlignment {
	private enum CrossAligment: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> CGFloat {
			d[.bottom]
		}
	}
	static let crossAlignment = VerticalAlignment(CrossAligment.self)
}

struct AlignmentZStackView: View {
	var body: some View {
		HStack(alignment: .crossAlignment, spacing: 20) {
			Circle()
				.foregroundStyle(.purple)
				.frame(width: 100)
				.alignmentGuide(.crossAlignment, computeValue: { d in
					d[VerticalAlignment.center]
				})
			
			VStack {
				Rectangle()
					.foregroundStyle(.green)
					.frame(width: 100, height: 100)
				Rectangle()
					.foregroundStyle(.red)
					.frame(width: 100, height: 100)
				Rectangle()
					.foregroundStyle(.blue)
					.frame(width: 100, height: 100)
					.alignmentGuide(.crossAlignment, computeValue: { d in
						d[VerticalAlignment.center]
					})
				Rectangle()
					.foregroundStyle(.green)
					.frame(width: 100, height: 100)
			}
		}
		.padding()
	}
}

#Preview {
	AlignmentZStackView()
}
