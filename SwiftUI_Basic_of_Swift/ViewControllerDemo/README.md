# SwiftUI+UIKit

- UIView를 SwiftUI에 통합하기

개별 또는 소규모의 UIKit 기반 컴포넌트를 SwiftUI와 통합하는데 유용한 방법

- UIViewRepresentable 프로토콜을 따르는 구조체로 UIView 인스턴스를 래핑하고,
- SwiftUI 레이아웃에 포함된 뷰를 초기화하고 관리하기 위해 makeUIView() 및 updateView() 를 구현
- 델리게이트 또는 데이터 소스가 필요한 UIKit 객체의 경우 래퍼에 Coordinator 클래스를 추가하고 makeCoordinator() 메서드 호출을 통해 뷰에 할당

- SwiftUI -> ViewControllerDemo 프로젝트를 생성

UIImagePickerController를 UIViewControllerRepresentable 래핑하기

코디네이터 구현 : 이벤트에 대한 반응이 필요한 뷰일 경우

전체 화면 레이아웃과 기능을 나타내는 모든 UIKit 뷰 컨트롤을 통합하는데 유용한 방법

- UIViewControllerRepresentable 프로토콜을 준수하는 구조체로 뷰 컨트롤러를 래핑하고
- 관련 메서드를 구현하는 UIView의 통합 작업과 유사
- UIView 통합과 마찬가지로 뷰 컨트롤러의 델리게이트와 데이터 소스는 Coordinator 인스턴스를 사용하여 처리

```swift
import SwiftUI

struct MyImagePicker: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MyImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MyImagePicker>)) {
        
    }

}
```

```swift
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
                
                Button("Select an Image") {
                    imagePickerVisible.toggle()
                }
            }
            .padding()
            
            if imagePickerVisible {
                MyImagePicker()
            }
            
        }
    }
}
```

MyImagePicker 완성하기

- ContentView 상태 프로퍼티에 대한 바인딩을 선언
- 이미지 선택 또는 취소시 알림처리를 위한 코디네이트 클래스 구현



```swift
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
    
    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<MyImagePicker>) {
        
    }
    
    // 이미지 선택 또는 취소시 알림처리를 위한 코디네이트 클래스 구현
    class Coordinator: NSObject,
                        UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {
        
        @Binding var imagePickerVisible: Bool
        @Binding var selectedImage: Image?
        
        init(imagePickerVisible: Binding<Bool>,
             selectedImage: Binding<Image?>) {
            
            _imagePickerVisible = imagePickerVisible
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
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
```

```swift
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
                
                Button("Select an Image") {
                    imagePickerVisible.toggle()
                }
            }
            .padding()
            
            if imagePickerVisible {
                MyImagePicker(
                    imagePickerVisible: $imagePickerVisible,
                    selectedImage: $selectedImage)
            }
            
        }
    }
}
```

