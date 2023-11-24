# SwiftUI+UIKit

- UIView를 SwiftUI에 통합하기

개별 또는 소규모의 UIKit 기반 컴포넌트를 SwiftUI와 통합하는데 유용한 방법

- UIViewRepresentable 프로토콜을 따르는 구조체로 UIView 인스턴스를 래핑하고,
- SwiftUI 레이아웃에 포함된 뷰를 초기화하고 관리하기 위해 makeUIView() 및 updateView() 를 구현
- 델리게이트 또는 데이터 소스가 필요한 UIKit 객체의 경우 래퍼에 Coordinator 클래스를 추가하고 makeCoordinator() 메서드 호출을 통해 뷰에 할당

- SwiftUI ->  UIViewDemo 앱

UIScrollView 래핑

코디네이터 구현 : 이벤트에 대한 반응이 필요한 뷰일 경우

전체 화면 레이아웃과 기능을 나타내는 모든 UIKit 뷰 컨트롤을 통합하는데 유용한 방법

- UIViewControllerRepresentable 프로토콜을 준수하는 구조체로 뷰 컨트롤러를 래핑하고
- 관련 메서드를 구현하는 UIView의 통합 작업과 유사
- UIView 통합과 마찬가지로 뷰 컨트롤러의 델리게이트와 데이터 소스는 Coordinator 인스턴스를 사용하여 처리

```swift
import SwiftUI

//UIScrollView 래핑
struct MyScrollView: UIViewRepresentable {
    
    var text: String
    
    func makeUIView(context: UIViewRepresentableContext<MyScrollView>) -> UIScrollView {
        let scrollView = UIScrollView()
        // 코디네이터를 델리게이트로 추가
        scrollView.delegate = context.coordinator
        
        scrollView.refreshControl = UIRefreshControl()
        // 리프레시 컨트롤에 대한 타깃으로 handleRefresh() 메서드를 추가
        scrollView.refreshControl?.addTarget(context.coordinator,
                                             action: #selector(Coordinator.handleRefresh),
                                             for: UIControl.Event.valueChanged)
        
        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50) )
        myLabel.text = text
        scrollView.addSubview(myLabel)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    // 코디네이터 구현 : 이벤트에 대한 반응이 필요한 뷰일 경우
    class Coordinator: NSObject, UIScrollViewDelegate {
        var control: MyScrollView
        
        init(_ control: MyScrollView) {
            self.control = control
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            print("View is Scrolling")
        }
        
        @objc func handleRefresh(sender: UIRefreshControl) {
            sender.endRefreshing()
        }
    }
    
    // Coordinator 클래스의 인스턴스를 생성하고 뷰에 할당
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

}
```

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            // MyScrollView 사용하기
            MyScrollView(text: "UIView in SwiftUI")
        }
        .padding()
    }
}
```
