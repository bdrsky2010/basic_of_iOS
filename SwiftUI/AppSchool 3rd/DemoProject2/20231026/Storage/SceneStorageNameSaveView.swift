//
//  SceneStorageNameSaveView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct SceneStorageNameSaveView: View {
	
	@SceneStorage("myName") var inputName: String = ""
	
	var body: some View {
		Text("이름을 적어라~")
			.font(.largeTitle)
			.fontWeight(.bold)
			.padding(30)
			.frame(maxWidth: .infinity)
		TextEditor(text: $inputName)
			.padding(30)
			.font(.largeTitle)
	}
}

#Preview {
	SceneStorageNameSaveView()
}
