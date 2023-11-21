 # iOS Swift 의 디렉터리 처리 및 파일 I/O 앱
 
 1. 앱 개요
	- 텍스트필드와 버튼으로 구성된 화면
	- 사용자가 텍스트필드에 텍스트를 입력한 후 버튼을 터치하면 해당 택스트가 파일에 저장
	- 다음에 앱이 시작되면 앱에서 파일 내용을 읽고 텍스트필드에 미리 로드
 
 2. 사용자 인터페이스 디자인하기
	- Main.storyboard 파일을 선택하여 Interface Builder 환경에 로드
	- 그런 다음 라이브러리에서 버튼(Save)과 텍스트필드를 뷰 컨트롤러로 드래하여 추가
	- @IBOutlet, @IBAction 드래그하여 연결
	
## 임시 파일을 저장하기 위한 tmp 디렉토리

```swift
 // 임시 파일을 저장하기 위한 tmp 디렉터리
 let tmpDir = NSTemporaryDirectory()
```
