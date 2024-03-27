//
//  SliderGridExamView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/8/23.
//

import SwiftUI

struct SliderGridExamView: View {
	@State private var floatingPoint: Double = 0.0
	@State private var gridItems: [GridItem] = [ GridItem() ]
	@State private var oldValue: Double = 0.0
	
	var body: some View {
		VStack {
			Slider(value: $floatingPoint, in: 0...4, step: 1)
				.onChange(of: floatingPoint) { newValue in
					if oldValue > newValue {
						gridItems.remove(at: 0)
					}
					if oldValue < newValue {
						gridItems.append(GridItem())
					}
					oldValue = floatingPoint
				}
			
			Spacer()
			
			LazyVGrid(columns: gridItems, spacing: 5) {
				ForEach((0...4), id: \.self) { index in
					CellContent2(index: index, color: .red)
				}
			}
			
			Spacer()
			
			LazyVGrid(columns: Array(repeating: GridItem(), count: Int(floatingPoint + 1)), spacing: 5) {
				ForEach((0...4), id: \.self) { index in
					CellContent2(index: index, color: .red)
				}
			}
			Spacer()
		}
		.padding()
	}
}

struct CellContent2: View {
	var index: Int
	var color: Color
	
	var body: some View {
		Text("\(index)")
			.frame(minWidth: 75, minHeight: 50)
			.background(color)
			.clipShape(.rect(cornerRadius: 8))
			.font(.largeTitle)
	}
}

#Preview {
	SliderGridExamView()
}
