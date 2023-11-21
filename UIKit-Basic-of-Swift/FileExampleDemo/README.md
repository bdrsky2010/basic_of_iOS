 # iOS Swift 의 디렉터리 처리 및 파일 I/O 앱
 
 1. 앱 개요
	- 텍스트필드와 버튼으로 구성된 화면
	- 사용자가 텍스트필드에 텍스트를 입력한 후 버튼을 터치하면 해당 택스트가 파일에 저장
	- 다음에 앱이 시작되면 앱에서 파일 내용을 읽고 텍스트필드에 미리 로드
 
 2. 사용자 인터페이스 디자인하기
	- Main.storyboard 파일을 선택하여 Interface Builder 환경에 로드
	- 그런 다음 라이브러리에서 버튼(Save)과 텍스트필드를 뷰 컨트롤러로 드래하여 추가
	- @IBOutlet, @IBAction 드래그하여 연결
	
<details>
<summary>Directory</summary>

<!-- summary 아래 한칸 공백 두어야함 -->
  ## 임시 파일을 저장하기 위한 tmp 디렉토리

```swift
 // 임시 파일을 저장하기 위한 tmp 디렉터리
 let tmpDir = NSTemporaryDirectory()
```

## 현재 작업 디렉토리 이동(변경)

```swift
 let filemgr = FileManager.default
 let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
 let docsDir = dirPaths[0].path
 if filemgr.changeCurrentDirectoryPath(docsDir) {
  // Success
 } else {
  // Failure :실패 결과는 일반적으로 지정된 디렉터리가 존재하지 않거나 앱에 적절한 액세스 권한이 없을 때
 }
```

## 새 디렉토리 생성

```swift
 //  withIntermediateDirectories 인수를 true로 설정하면 하위 디렉터리가 자동으로 생성
 let filemgr = FileManager.default
 let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
 let docsURL = dirPaths[0]
 let newDir = docsURL.appendingPathComponent("data").path
 do {
	 try filemgr.createDirectory(atPath: newDir,
								 withIntermediateDirectories: true, attributes: nil)
 } catch let error as NSError {
	 print("Error: \(error.localizedDescription)")
 }
```

## 디렉토리 삭제

```swift
 //  RemoveItem(atPath:) 메서드는 제거할 디렉터리의 경로를 인수로 전달하여 파일 시스템에서 기존 디렉터리를 제거
 do {
	 try filemgr.removeItem(atPath: newDir)
 } catch let error {
	 print("Error: \(error.localizedDescription)")
 }

```

## 디렉토리의 내용 나열

```swift
 // contentOfDirectory(atPath:) 메소드는 디렉터리 경로 이름을 인수로 사용하고
 // 해당 디렉터리의 파일 및 하위 디렉터리 이름이 포함된 배열 개체를 반환
 do {
	 let filelist = try filemgr.contentsOfDirectory(atPath: "/")
	 for filename in filelist {
		 print(filename)
	 }
 } catch let error {
	 print("Error: \(error.localizedDescription)")
 }
```

## 파일이나 디렉토리의 속성 얻기

```swift
 // attributeOfItem(atPath:) 메소드를 사용하여 파일이나 디렉토리의 속성을 얻을 수 있음
 // 결과는 NSDictionary 사전 개체 형식으로 반환
 let filemgr = FileManager.default
 do {
	 let attribs: NSDictionary = try filemgr.attributesOfItem(atPath: "/Applications") as NSDictionary
	 let type = attribs["NSFileType"] as! String
	 print("File type \(type)")
 } catch let error {
	 print("Error: \(error.localizedDescription)")
 }
```

## 반환 사전의 키

```swift
 NSFileType
 NSFileTypeDirectory
 NSFileTypeRegular
 NSFileTypeSymbolicLink
 NSFileTypeSocket
 NSFileTypeCharacterSpecial
 NSFileTypeBlockSpecial
 NSFileTypeUnknown
 NSFileSize
 NSFileModificationDate
 NSFileReferenceCount
 NSFileDeviceIdentifier
 NSFileOwnerAccountName
 NSFileGroupOwnerAccountName
 NSFilePosixPermissions
 NSFileSystemNumber
 NSFileSystemFileNumber
 NSFileExtensionHidden
 NSFileHFSCreatorCode
 NSFileHFSTypeCode
 NSFileImmutable
 NSFileAppendOnly
 NSFileCreationDate
 NSFileOwnerAccountID
 NSFileGroupOwnerAccountID
```
</details>

<details>
<summary>FileManager</summary>

<!-- summary 아래 한칸 공백 두어야함 -->
  
</details>

<details>
<summary>FileHandler</summary>

<!-- summary 아래 한칸 공백 두어야함 -->
  
</details>

## 

```swift

```

## 

```swift

```

## 

```swift

```

## 

```swift

```

## 

```swift

```

## 

```swift

```
