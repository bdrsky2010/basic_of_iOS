//
//  AppStorageColorPickerView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct AppStorageColorPickerView: View {
	@AppStorage("myCGColor") var saveCGColor: String = ""
	
	@State var colorPick: CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
	@State var loadColor: CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
	
	let colors: [Color] = [.black, .blue, .brown, .yellow]
	let colornames: [String] = ["Black", "Blue", "Brown", "Yellow"]
	
	var body: some View {
		VStack{
			Spacer()
			ColorPicker(selection: Binding(get: { colorPick }, set: { newValue in
				self.colorPick = newValue
			})) {
				Text("색상변경")
					.foregroundStyle(.white)
					.font(.largeTitle)
					.fontWeight(.bold)
			}
			.onChange(of: colorPick) { newValue in
				print(newValue)
				let cgColor: CGColor = newValue
				guard let color = cgColor.components else { return }
				self.saveCGColor = colorToString(color)
			}
			Spacer()
		}
		.onAppear {
			self.loadColor = stringToColor(saveCGColor)
			self.colorPick = loadColor
		}
		.background(Color(cgColor: colorPick))
	}
	
	func colorToString(_ color: [CGFloat]) -> String {
		return "\(color[0]) \(color[1]) \(color[2]) \(color[3])"
	}
	
	func stringToColor(_ color: String) -> CGColor {
		guard !color.isEmpty else { return CGColor(red: 0, green: 0, blue: 0, alpha: 0) }
		let rgba: [Float] = color.components(separatedBy: " ").map { Float($0) ?? 0 }
		print(CGColor(red: CGFloat(rgba[0]), green: CGFloat(rgba[1]), blue: CGFloat(rgba[2]), alpha: CGFloat(1)))
		return CGColor(red: CGFloat(rgba[0]), green: CGFloat(rgba[1]), blue: CGFloat(rgba[2]), alpha: CGFloat(1))
	}
}

#Preview {
	AppStorageColorPickerView()
}
