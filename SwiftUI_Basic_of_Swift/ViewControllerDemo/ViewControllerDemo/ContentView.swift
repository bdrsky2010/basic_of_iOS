//
//  ContentView.swift
//  ViewControllerDemo
//
//  Created by Minjae Kim on 11/24/23.
//

import SwiftUI

struct ContentView: View {
	
	@State var imagePickerVisible: Bool = false
	@State var selectedImage: Image? = Image(systemName: "photo")
	
    var body: some View {
		ZStack {
			VStack {
				selectedImage?
					.resizable()
					.aspectRatio(contentMode: .fit)
				Button("select an Image") {
					withAnimation {
						imagePickerVisible.toggle()
					}
				}
			}
			.padding()
			
			if imagePickerVisible {
				MyImagePicker(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
			}
		}
    }
}

#Preview {
    ContentView()
}
