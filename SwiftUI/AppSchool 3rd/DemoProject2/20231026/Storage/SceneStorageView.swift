//
//  SceneStorageView.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/26/23.
//

import SwiftUI

struct SceneStorageView: View {
	
	@SceneStorage("mytext1") var editorText: String = "Sample Text"
	
	var body: some View {
		TextEditor(text: $editorText)
			.padding(30)
			.font(.largeTitle)
	}
}

#Preview {
	SceneStorageView()
}
