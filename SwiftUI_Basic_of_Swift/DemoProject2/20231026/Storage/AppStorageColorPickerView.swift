//
//  AppStorageColorPickerView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct Rgba: Codable {
	var red: CGFloat
	var green: CGFloat
	var blue: CGFloat
	var alpha: CGFloat
}

class ColorData: ObservableObject {
	// AppStorage를 통해 CGColor의 RGBA data를 문자열 형태로 Local Storage에 저장하는 프로퍼티
	@AppStorage("myCGColor") var saveCGColor: String = ""
	@AppStorage("myColor") var colorStore: Data = Data()
	
	// ColorPicker에서 pick한 color의 CGColor data 저장 및
	// AppStorage에 저장한 CGColor를 다시 Load 하여 저장하는 프로퍼티
	@Published var colorPick: CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
	
	func colorToString(_ color: [CGFloat]) -> String {
		guard color != [] else { return "0 0 0 1" }
		return "\(color[0]) \(color[1]) \(color[2]) \(color[3])"
	}
	
	func stringToColor(_ color: String) -> CGColor {
		let rgba: [Float] = color.components(separatedBy: " ").map { Float($0) ?? 0 }
		print(CGColor(red: CGFloat(rgba[0]), green: CGFloat(rgba[1]), blue: CGFloat(rgba[2]), alpha: CGFloat(1)))
		return CGColor(red: CGFloat(rgba[0]), green: CGFloat(rgba[1]), blue: CGFloat(rgba[2]), alpha: CGFloat(1))
	}
	
	func encoding() {
		let encoder = JSONEncoder()
		guard let data = try? encoder.encode(colorPick.components) else { return }
		colorStore = data
	}
	
	func decoding() {
		let decoder = JSONDecoder()
		guard let data = try? decoder.decode(Rgba.self, from: colorStore) else { return }
		colorPick = CGColor(red: data.red, green: data.green, blue: data.blue, alpha: 1)
	}
}

struct AppStorageColorChangeView: View {
	@EnvironmentObject var colorData: ColorData
	
	var body: some View {
		VStack {
			Spacer()
			Text("색 변경 확인 View")
				.foregroundStyle(.white)
				.font(.largeTitle)
				.fontWeight(.bold)
				.frame(maxWidth: .infinity)
			Spacer()
		}
		.background(Color(cgColor: colorData.colorPick))
	}
}

struct AppStorageColorPickerView: View {
	// ObservableObject인 ColorData 객체를 가져오는 StateObject 프로퍼티
	@StateObject var colorData: ColorData = ColorData()
	
	var body: some View {
		VStack{
			Spacer()
			ColorPicker(selection: Binding(get: {
				colorData.colorPick
			}, set: { newValue in
				print("picker", newValue)
				colorData.colorPick = newValue
			})) {
				Text("색상변경")
					.font(.largeTitle)
					.fontWeight(.bold)
			}
			.padding()
			.onChange(of: colorData.colorPick) { newValue in
				let cgColor: [CGFloat] = newValue.components ?? []
				colorData.saveCGColor = colorData.colorToString(cgColor)
			}
			NavigationLink(destination: AppStorageColorChangeView().environmentObject(colorData)) {
				Text("색 변경 확인").frame(maxWidth: .infinity)
			}
			.buttonStyle(.borderedProminent)
			.padding()
			Spacer()
		}
		.onAppear {
			colorData.colorPick = colorData.stringToColor(colorData.saveCGColor)
		}
	}
}

#Preview {
	AppStorageColorPickerView()
}
