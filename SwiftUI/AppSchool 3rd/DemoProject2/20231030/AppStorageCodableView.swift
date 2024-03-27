//
//  AppStorageCodableView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/30/23.
//

import SwiftUI

struct UserName: Codable {
	var firstName: String
	var secondName: String
}

struct AppStorageCodableView: View {
	
	@AppStorage("myText") var editorText: String = "Sample Text"
	@AppStorage("username") var nameStore: Data = Data()
	
	@State var username = UserName(firstName: "kim", secondName: "minjae")
	
	var body: some View {
		VStack {
			HStack {
				TextField("firstname", text: $username.firstName)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				TextField("secondname", text: $username.secondName)
					.textFieldStyle(RoundedBorderTextFieldStyle())
			}
			.padding()
			
			Button("username save") {
				let encoder = JSONEncoder()
				if let data = try? encoder.encode(username) {
					nameStore = data
				}
			}
			.buttonStyle(.borderedProminent)
			
			TextEditor(text: $editorText)
				.padding()
				.font(.largeTitle)

		}
		.background(Color.teal)
		.onAppear {
			let decoder = JSONDecoder()
			if let name = try? decoder.decode(UserName.self, from: nameStore) {
				username = name
			}
		}
	}
}

#Preview {
	AppStorageCodableView()
}
