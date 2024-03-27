//
//  MyImagePicker.swift
//  ViewControllerDemo
//
//  Created by Minjae Kim on 11/24/23.
//

import SwiftUI

struct MyImagePicker: UIViewControllerRepresentable {
	
	// ContentView 상태 프로퍼티에 대한 바인딩을 선언
	@Binding var imagePickerVisible: Bool
	@Binding var selectedImage: Image?
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<MyImagePicker>) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.delegate = context.coordinator
		return picker
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MyImagePicker>) {
		
	}
	
	// 이미지 선택 또는 취소시 알림처리를 위한 코디네이터 클래스 구현
	class Coordinator: NSObject, 
						UINavigationControllerDelegate,
						UIImagePickerControllerDelegate {
		
		@Binding var imagePickerVisible: Bool
		@Binding var selectedImage: Image?
		
		init(imagePickerVisible: Binding<Bool>, selectedImage: Binding<Image?>) {
			_imagePickerVisible = imagePickerVisible
			_selectedImage = selectedImage
		}
		
		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			let uiImage = info[.originalImage] as! UIImage
			selectedImage = Image(uiImage: uiImage)
			
			imagePickerVisible = false
		}
		
		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			imagePickerVisible = false
		}
	}
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
	}
}

//#Preview {
//    MyImagePicker()
//}
