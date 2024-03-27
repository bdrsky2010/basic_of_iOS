//
//  AlignmentView2.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/30/23.
//

import SwiftUI

extension VerticalAlignment {
	private enum OneThird: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> CGFloat {
			d.height / 3
		}
	}
	static let oneThird = VerticalAlignment(OneThird.self)
}

struct AlignmentView2: View {
    var body: some View {
			VStack(spacing: 50) {
				// 커스텀 정렬 타입 p.288
				HStack(alignment: .oneThird) {
					Rectangle()
						.foregroundStyle(.green)
						.frame(width: 50, height: 100)
					
					Rectangle()
						.foregroundStyle(.red)
						.frame(width: 50, height: 100)
						.alignmentGuide(.oneThird, computeValue: { d in
							d[VerticalAlignment.top]
						})
					
					Rectangle()
						.foregroundStyle(.blue)
						.frame(width: 50, height: 100)
					
					Rectangle()
						.foregroundStyle(.orange)
						.frame(width: 50, height: 100)
						.alignmentGuide(.oneThird, computeValue: { d in
							d[VerticalAlignment.bottom]
						})
				}
			}
    }
}

#Preview {
    AlignmentView2()
}
