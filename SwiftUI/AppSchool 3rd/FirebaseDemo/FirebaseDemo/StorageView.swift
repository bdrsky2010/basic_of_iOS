//
//  StorageView.swift
//  FirebaseDemo
//
//  Created by Minjae Kim on 1/8/24.
//

import SwiftUI

struct StorageView: View {
	
	@ObservedObject var storageManager = StorageManager.shared
	@State private var image = UIImage()
	@State var showSheet: Bool = false
	
    var body: some View {
		VStack {
			HStack {
				Image(uiImage: self.image)
					.resizable()
					.frame(width: 100, height: 100)
					.background(.black.opacity(0.2))
					.clipShape(Circle())
				
				Text("Change Photo")
					.font(.headline)
					.frame(maxWidth: .infinity)
					.frame(height: 50)
					.onTapGesture {
						showSheet = true
					}
			}
			.padding(.horizontal, 20)
			.sheet(isPresented: $showSheet) {
				ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
			}
			.onChange(of: image) {
				storageManager.upload(image: image)
			}
			
			Button("Load") {
				storageManager.listAllFiles()
			}
			Spacer()
			List {
				ForEach(storageManager.images, id: \.self) { image in
					HStack {
						Image(uiImage: image.image)
							.resizable()
							.frame(width: 60, height: 60)
							.background(.black.opacity(0.2))
							.clipShape(Circle())
						Text(image.name)
						Text(image.fullPath)
					}
				}
				.onDelete(perform: { indexSet in
					for index in indexSet {
						storageManager.deleteItem(fullPath: storageManager.images[index].fullPath)
					}
				})
			}
		}
	}
}

#Preview {
    StorageView()
}
