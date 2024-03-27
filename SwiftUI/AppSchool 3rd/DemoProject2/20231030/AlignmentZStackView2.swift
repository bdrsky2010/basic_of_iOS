//
//  AlignmentZStackView2.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/30/23.
//

import SwiftUI

// p.294
extension HorizontalAlignment {
	enum MyHorizontal: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> CGFloat {
			d[HorizontalAlignment.center]
		}
	}
	static let myAlignment = HorizontalAlignment(MyHorizontal.self)
}

// p.294
extension VerticalAlignment {
	private enum MyVertical: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> CGFloat {
			d[VerticalAlignment.center]
		}
	}
	static let myAlignment = VerticalAlignment(MyVertical.self)
}

// p295
extension Alignment {
	static let myAlignment = Alignment(horizontal: HorizontalAlignment.myAlignment, vertical: VerticalAlignment.myAlignment)
}

struct AlignmentZStackView2: View {
	var body: some View {
		ZStack(alignment: Alignment.myAlignment) {
			Rectangle()
				.foregroundStyle(.green)
				.alignmentGuide(HorizontalAlignment.myAlignment) { d in
					d[HorizontalAlignment.trailing]
				}
				.alignmentGuide(VerticalAlignment.myAlignment) { d in
					d[VerticalAlignment.bottom]
				}
				.frame(width: 100, height: 100)
			
			Rectangle()
				.foregroundStyle(.red)
				.alignmentGuide(HorizontalAlignment.myAlignment) { d in
					d[HorizontalAlignment.center]
				}
				.alignmentGuide(VerticalAlignment.myAlignment) { d in
					d[VerticalAlignment.top]
				}
				.frame(width: 100, height: 100)
			
			Circle()
				.foregroundStyle(.red)
				.alignmentGuide(HorizontalAlignment.myAlignment) { d in
					d[HorizontalAlignment.leading]
				}
				.alignmentGuide(VerticalAlignment.myAlignment) { d in
					d[VerticalAlignment.bottom]
				}
				.frame(width: 100, height: 100)
		}
	}
}

#Preview {
	AlignmentZStackView2()
}
