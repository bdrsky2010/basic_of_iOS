//
//  RotateText.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/13/23.
//

import SwiftUI

struct RotateText: View {
	let wordSetting: WordSetting = WordSetting()
	
	var body: some View {
		VStack {
			WordDisplayView()
			Divider()
			AngleControlView()
			WordControlView()
			ColorMenu()
		}
		.environmentObject(wordSetting)
	}
}

class WordSetting: ObservableObject {
	@Published var angle: Double = 0.0
	@Published var word: String = "word"
	@Published var color: CGColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
	@Published var colorPick: Color = .black
}

struct AngleControlView: View {
	@EnvironmentObject var angleSetting: WordSetting
	var body: some View {
		Slider(value: $angleSetting.angle, in: 0...360)
	}
}

struct WordControlView: View {
	@EnvironmentObject var wordSetting: WordSetting
	var body: some View {
		TextField("word", text: $wordSetting.word)
			.textFieldStyle(.roundedBorder)
	}
}

struct ColorMenu: View {
	@EnvironmentObject var wordSetting: WordSetting
	
	@State private var colorIndex: Int = 0
	let colors: [Color] = [.black, .blue, .brown, .yellow]
	let colornames: [String] = ["Black", "Blue", "Brown", "Yellow"]
	
	var body: some View {
		ColorPicker("색상변경", selection: $wordSetting.color)
		Divider()
		Picker(selection: $colorIndex, label: Text("색상변경")) {
			ForEach(0..<colors.count, id: \.self) { color in
				Text(colornames[color])
					.foregroundStyle(colors[color])
			}
		}
		.pickerStyle(.wheel)
		.onChange(of: colorIndex) { newValue in
			self.wordSetting.colorPick = colors[colorIndex]
		}
	}
}

struct WordDisplayView: View {
	@EnvironmentObject var wordSetting: WordSetting
	var body: some View {
		Text("\(wordSetting.word)")
//			.foregroundStyle(Color.init(uiColor: UIColor(cgColor: wordSetting.color)))
			.foregroundStyle(wordSetting.colorPick)
			.lineLimit(1...1)
			.font(.system(size: 100, weight: .bold, design: .rounded))
			.rotationEffect(.degrees(wordSetting.angle))
			.animation(.easeInOut(duration: 2), value: wordSetting.angle)
	}
}

#Preview {
	RotateText()
}

/*
 class ClassExampleObject: ObservableObject {
		 @Published var integer: Int = 0
 }

 struct ClassExampleView: View {
		 
		 @State private var isOn: Bool = false
		 @StateObject var obj: ClassExampleObject = ClassExampleObject()

		 var body: some View {
				 NavigationStack {
						 Text("FirstViewValue: \(obj.integer)")
						 
						 Button(action: {
								 obj.integer += 10
						 }, label: {
								 Text("change integer value")
						 })
						 
						 Button(action: {
								 isOn = true
						 }, label: {
								 Text("navigate to second")
						 })
						 .padding(.bottom, 60)
						 
						 SecondClassExampleView()
								 .environmentObject(obj)
				 }
				 
		 }
 }

 struct SecondClassExampleView: View {
		 
		 @EnvironmentObject var obj: ClassExampleObject

		 var body: some View {
				 Text("SecondViewValue: \(obj.integer)")
		 }
 }
 */
