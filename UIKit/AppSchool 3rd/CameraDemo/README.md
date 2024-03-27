# 카메라 및 사진 라이브러리 액세스하기

iOS SDK는 UIImagePickerController 클래스를 통해 카메라 장치와 사진 라이브러리에 대한 액세스를 제공

이를 통해 앱 내에서 비디오와 사진을 촬영하고 기존 사진과 비디오를 사용자에게 표시 가능

UIImagePickerController 클래스

> UIImagePickerController 클래스의 목적은 앱에 이미지나 비디오를 제공하는 것

- 사용자에게 장치의 카메라 롤 및 사진 라이브러리에 대한 액세스를 제공하여 이 작업을 수행
- 카메라의 경우 사용자는 장치의 기능과 앱의 UIImagePickerController 개체 구성에 따라 사진을 찍거나 비디오를 녹화할 수 있음
- 카메라 롤 및 라이브러리 액세스와
관련하여 개체는 사용자가 선택한 기존 이미지 또는 비디오를 앱에 제공
- 또한 컨트롤러를 사용하면 앱 내에서 생성된 새로운 사진과 비디오를 라이브러리에 저장할 수도 있음

UIImagePickerController 인스턴스 생성 및 구성

- UIImagePickerController를 사용하려면 먼저 클래스의 인스턴스를 생성
 - 이미지 또는 비디오의 소스(카메라, 카메라 롤 또는 라이브러리)를 제어하려면 인스턴스의 속성을 구성해야 함
 - 또한 앱에서 허용되는 미디어 유형(사진, 비디오 또는 둘 다)도 정의해야 함
 - 마지막 구성 옵션은 사진을 찍은 후 앱에 전달하기 전에 사용자가 사진을 편집할 수 있는지 여부를 정의해야함

> 미디어 소스는 UIImagePickerController 객체의 sourceType 속성을 지원되는 세 가지 유형 중 하나로 설정
- UIImagePickerController.SourceType.camera
- UIImagePickerController.SourceType.savedPhotosAlbum
- UIImagePickerController.SourceType.photoLibrary


- 앱에 허용되는 미디어 유형은 비디오와 이미지를 모두 지원하도록 구성할 수 있는 Array 객체인 mediaTypes 속성을 설정하여 정의

- MobileCoreServices Framework의 kUTTypeImage 및 kUTTypeMovie 정의는 이 속성을 구성할 때 값으로 사용될 수 있음

- 이미지가 앱에 전달되기 전에 사용자가 편집을 수행할 수 있는지 여부는 allowsEditing Boolean 속성을 통해 제어

```swift
let imagePicker = UIImagePickerController()

imagePicker.delegate = self
imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
imagePicker.mediaTypes = [kUTTypeImage as String]
imagePicker.allowsEditing = false

self.present(imagePicker, animated: true, completion: nil)

```

UIImagePickerController Delegate 구성

- 사용자에게 UIImagePickerController 개체 사용자 인터페이스가 표시되면 앱은 기본적으로 해당 개체에 제어권을 넘겨줌
  - 컨트롤러는 사용자가 사진을 찍거나 비디오를 녹화했거나 라이브러리를 선택했음을 앱에 알리는 방법이 필요(이는 대리자 메서드를 호출하여 수행)
  - UIImagePickerController 를 인스턴스화하는 클래스는 자신을 객체의 대리자로 선언하고
    - UIImagePickerControllerDelegate 및 UINavigationControllerDelegate 프로토콜을 준수하며
    - didFinishPickingMediaWithInfo
    및 imagePickerControllerDidCancel 메서드를 구현해야 함

- 예를 들어 사용자가 미디어를 선택하거나 생성하면 didFinishPickingMediaWithInfo 메서드가 호출되고 미디어 및 관련 데이터가 포함된 NSDictionary 개체가 전달
  - 사용자가 작업을 취소하면 imagePickerControllerDidCancel 메소드가 호출
  - 두 경우 모두 뷰 컨트롤러를 닫는 것은 대리자 메서드의 책임

```swift
    func imagePickerController(_ picker: UIImagePickerController,
     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // UIImagePickerController.InfoKey.mediaType
        let mediaType = info[.mediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
```

- didFinishPickingMediaWithInfo 메소드에 전달된 info 인수는 사용자가 생성하거나 선택한 이미지 또는 비디오와 관련된 데이터를 포함하는 NSDictionary 객체

```swift
    let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
    if mediaType.isEqual(to: kUTTypeImage as String) {
        // Media is an image
        
    } else if mediaType.isEqual(to: kUTTypeMovie as String) {
        // Media is a video
    }

```

```swift
// 사용자가 선택하거나 촬영한 편집되지 않은 원본 이미지
let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

// 이미지 선택기 컨트롤러 객체에 편집이 활성화되어 있다고 가정하면, 편집된 이미지 버전은 UImagePickerControllerEditedImage 사전 키를 통해 접근
let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage

// 미디어가 비디오인 경우 녹화된 미디어의 URL은 다음과 같이 액세스
let url = info[UIImagePickerController.InfoKey.mediaURL]
```

- 이미지 또는 비디오 URL을 얻은 후에 앱은 선택적으로 미디어를 라이브러리에 저장하고 이미지를 사용자에게 표시하거나
- AVPlayer 및 AVPlayerViewController 클래스를 사용하여 비디오를 재생

CameraDemo 앱 시작

사용자 인터페이스 디자인
- 이미지 뷰, 도구 모음`toolbar` 및 두 개의 버튼 항목으로 구성
- @IBOutlet, @IBAction 연결

카메라 및 사진라이브러 액세스 권한 얻기

> 사용자가 장치 카메라에 액세스하고 이미지를 검색하고 사진 라이브러리에 추가할 수 있는
권한을 얻기 위해 적절한 개인 정보 보호 사용 키를 구성해야 함

- 카메라와 장치에 저장된 사진 모두에 액세스하려면 사용자의 승인이 필요
  - 프로젝트 탐색기 패널 상단에서 카메라 항목을 선택하고 기본 패널에서 정보 `Info` 탭을 선택
  - 다음으로, `Custom iOS Target Properties` 섹션의 마지막 속성 줄에`last line of properties` 포함된 `+` 버튼을 클릭
  - 그런 다음 나타나는 메뉴에서 개인 정보 ‒ 카메라 사용 설명`Privacy – Camera Usage Description` 항목을 선택
  - 키가 추가되면 해당 값 열을 두 번 클릭하고 사용자가 보기를 원하는 메세지를 입력

예시
```
이 앱을 사용하면 사진을 찍어 사진 라이브러리에 저장할 수 있습니다.

```

앱 확장 - 비디오 재생 AVPlayer 및 AVPlayerViewController 사용

AVPlayer 및 AVPlayerViewController 클래스

- AVPlayer 클래스의 유일한 목적은 미디어 콘텐츠를 재생하는 것
  - AVPlayer 인스턴스는 재생할 미디어의 URL(장치의 로컬 파일 경로 또는 네트워크 기반 미디어의 URL)로 초기화

- AVKit Player View Controller(AVPlayerViewController) 클래스는 사용자가 재생 경험을 관리할 수 있는 여러 컨트롤과 함께 AVPlayer 비디오가 사용자에게 표시되는 뷰 컨트롤러 환경을 제공
  - AVPlayer 인스턴스의 재생 및 일시 중지 메서드를 호출하여 앱 코드 내에서 재생을 제어할 수도 있음

```swift
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination as! AVPlayerViewController
        let url = URL(string: "https://www.ebookfrenzy.com/ios_book/movie/movie.mov")
        
        if let movieURL = url {
            dest.player = AVPlayer(url: movieURL)
        }
    }
```
