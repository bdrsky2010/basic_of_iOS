//
//  ExCruveView.swift
//  DrawDemo
//
//  Created by Minjae Kim on 12/20/23.
//

import SwiftUI

struct ExCruveView: View {
	var body: some View {
		ZStack {
			Path { path in
				path.move(to: CGPoint(x: 20, y: 60))
				path.addLine(to: CGPoint(x: 40, y: 60))
				path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
				path.addLine(to: CGPoint(x: 230, y: 60))
				path.addLine(to: CGPoint(x: 230, y: 100))
				path.addLine(to: CGPoint(x: 20, y: 100))
				path.closeSubpath()
			}
			.fill(.purple)
			
			Path { path in
				path.move(to: CGPoint(x: 20, y: 60))
				path.addLine(to: CGPoint(x: 40, y: 60))
				path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
				path.addLine(to: CGPoint(x: 230, y: 60))
				path.addLine(to: CGPoint(x: 230, y: 100))
				path.addLine(to: CGPoint(x: 20, y: 100))
				path.closeSubpath()
			}
			.stroke(.black, lineWidth: 5)
		}
	}
}

#Preview {
	ExCruveView()
}
