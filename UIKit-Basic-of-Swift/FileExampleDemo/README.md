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
  ## 파일 존재 여부 확인

```swift
 //  FileManager 인스턴스 참조
 let filemgr = FileManager.default

 // 파일 존재 여부 확인
 //  fileExists(atPath:) 메소드는 문제의 파일에 대한 경로를 포함하는 NSString 객체를 인수로 취하고 지정된 파일의 존재 여부를 나타내는 부울Boolean 값을 반환
 if filemgr.fileExists(atPath: "/Applications") {
	 print("File exists")
 } else {
	 print("File not found")
 }
```

## 두 파일의 내용 비교

```swift
 // contentEqual(atPath:) 메소드는 비교할 두 파일의 경로를 인수로 사용하고 파일 내용이 일치하는지 여부를 나타내는 부울Boolean 결과를 반환
 let filePath1 = docsDir + "/myfile1.txt"
 let filePath2 = docsDir + "/myfile2.txt"

 if filemgr.contentsEqual(atPath: filePath1, andPath: filePath2) {
	 print("File contents match")
 } else {
	 print("File contents do not match")
 }
```

## 파일이 읽기 / 쓰기 / 실행 / 삭제 가능한지 확인

```swift
 대부분의 운영체제는 일정 수준의 파일 엑세 제어를 제공
	- 일반적으로 각 사용자 또는 사용자 그룹의 파일에 대한 액세스 수준을 제어하도록 설계된 속성의 형태를 취함
 
 //  isReadableFile(atPath:), isWritableFile(atPath:), isExecutableFile(atPath:),  isDeletableFile(atPath:)  각 메서드는 확인할 파일 경로 형식의 단일 인수를 사용하고 부울 결과를 반환
 // 예를 들어 파일이 쓰기 가능한지 확인하는 코드
 if filemgr.isWritableFile(atPath: filePath1) {
	 print("File is writable")
 } else {
	 print("File is read-only")
 }
```

## 파일 이동 / 이름 바꾸기

```swift
 // moveItem(atPath:) 메서드는 이동할 파일의 경로 이름과 대상 경로를 인수로 사용
 // 대상 파일 경로가 이미 존재하는 경우 이 작업은 실패
 do {
	 try filemgr.moveItem(atPath: filePath1, toPath: filePath2)
	 print("Move successful")
 } catch let error {
	 print("Error: \(error.localizedDescription)")
 }
```

## 파일 복사

```swift
 // copyItem(atPath:) 메소드를 사용하여 파일 복사를 수행
 //  move 메소드와 마찬가지로 소스 및 대상 경로 이름을 인수로 사용

 do {
	 try filemgr.copyItem(atPath: filePath1, toPath: filePath2)
	 print("Copy successful")
 } catch let error {
	 print("Error: \(error.localizedDescription)")
 }
```

## 파일 제거

```swift
 // RemoveItem(atPath:) 메소드는 파일 시스템에서 지정된 파일을 제거
 // 제거할 파일의 경로 이름을 인수로 사용
 do {
	 try filemgr.removeItem(atPath: filePath2)
	 print("Removal successful")
 } catch let error {
	 print("Error: \(error.localizedDescription)")
 }
```

## 심볼릭 링크 만들기

```swift
 // createSymbolicLink(atPath:) 메소드는 특정 파일에 대한 심볼릭 링크를 생성
 // 심볼릭 링크의 경로와 링크가 참조할 파일의 경로를 인수로 사용
 do {
	 try filemgr.createSymbolicLink(atPath: filePath2,
									withDestinationPath: filePath1)
	 print("Link successful")
 } catch let error {
	 print("Error: \(error.localizedDescription)")
 }
```
</details>

<details>
<summary>FileHandler</summary>

<!-- summary 아래 한칸 공백 두어야함 -->
  ## FileManager로 파일 읽기 및 쓰기

```swift
 /**
  FileManager 클래스에는 몇 가지 기본 파일 읽기 및 쓰기 기능이 포함
	- FileHandle 클래스에서 제공하는 옵션에 비해 다소 제한적
 
	- 기본적으로 기존 파일의 내용을 새 파일로 복사
	- 읽거나 쓸 데이터의 양을 제어할 수 없으며 기존 파일의 끝에 데이터를 추가하는 것을 허용하지 않음
	- 파일이 이미 존재하는 경우 해당 파일에 포함된 모든 데이터는 소스 파일의 내용으로 덮어쓰여짐
	- 좀 더 유연한 메커니즘이 필요하면 . Foundation Framework이 제공하는 FileHandle 클래스를 이용
 */
  // content(atPath:) 메소드를 사용하여 파일의 내용을 읽고 Data 객체에 저장
 let databuffer = filemgr.contents(atPath: filePath1)

 // Data 객체에 파일 내용을 저장한 후 해당 데이터는 createFile(atPath:) 메서드를 사용하여 새 파일에 기록
 filemgr.createFile(atPath: filePath2, contents: databuffer, attributes: nil)
```

## FileHandle 클래스를 사용하여 파일 작업하기

```swift
 /**
  FileHandle 객체 생성
 
  - FileHandle 객체는 읽기, 쓰기 또는 업데이트(즉, 읽기 및 쓰기 모두)를 위해 파일을 열 때 생성
  - 파일을 연 후 closeFile 메소드를 사용하여 작업을 마친 후에는 파일을 닫아야함
  - 존재하지 않는 파일을 읽기 위해 열려고 하여 파일 열기 시도가 실패하는 경우  메서드는 nil을 반환
 */
  let file: FileHandle? = FileHandle(forReadingAtPath: filePath1)
 if file == nil {
	 print("File open failed")
 } else {
	 file?.closeFile()
 }
```

## FileHandle 파일 오프셋 및 탐색

```swift
 /**
  FileHandle 객체는 파일의 현재 위치에 대한 포인터를 유지(오프셋)
 
  - 파일이 처음 열릴 때 오프셋은 0(파일의 시작 부분)으로 설정
  - FileHandle 인스턴스 메서드를 사용하여 수행된 모든 읽기 또는 쓰기 작업은 파일의 오프셋 0에서 발생
  - 따라서 파일의 다른 위치에서 작업을 수행하려면 먼저 필요한 오프셋을 이동
  - 예: 파일 끝에 데이터 추가, 현재 오프셋을 파일 끝으로 이동하려면eekToEndOfFile 메소드를 사용
	- seek(toFileOffset:)을 사용하면 파일에서 오프셋이 배치될 정확한 위치를 지정
	- offsetInFile 메소드를 사용하여 현재 오프셋을 식별
	- 오프셋은 대용량 파일을 수용할 수 있도록 부호 없는 64비트 정수로 저장
 */
 
  let file: FileHandle? = FileHandle(forReadingAtPath: filePath1)

 if file == nil {
	 print("File open failed")
 } else {
	 print("Offset = \(file?.offsetInFile ?? 0)")
	 file?.seekToEndOfFile()
	 print("Offset = \(file?.offsetInFile ?? 0)")
	 file?.seek(toFileOffset: 30)
	 print("Offset = \(file?.offsetInFile ?? 0)")
	 file?.closeFile()
 }
```

## 파일에서 데이터 읽기

```swift
  // readData(ofLength:) 메소드는 현재 오프셋에서 시작하여 파일에서 지정된 바이트 수의 데이터를 읽어옴
 // 읽은 데이터는 Data 객체에 캡슐화되어 반환
 // 또는, readDataToEndOfFile 메소드는 현재 오프셋에서 시작하여 파일의 모든 데이터를 읽어옴
 let file: FileHandle? = FileHandle(forReadingAtPath: filepath1)
 if file == nil {
	 print("File open failed")
 } else {
	 file?.seek(toFileOffset: 10)
	 let databuffer = file?.readData(ofLength: 5)
	 file?.closeFile()
 }
```

## 파일에 데이터 쓰기

```swift
  //  write 메소드는 파일의 오프셋 위치에서 시작하여 Data 객체에 포함된 데이터를 기록
 // 데이터가 삽입되지 않고 해당 위치에 있는 파일의 기존 데이터를 덮어씀
 let file: FileHandle? = FileHandle(forUpdatingAtPath: filePath1)
 if file == nil {
	 print("File open failed")
 } else {
	 if let data = ("black cat" as
					NSString).data(using: String.Encoding.utf8.rawValue) {
		 file?.seek(toFileOffset: 10)
		 file?.write(data)
		 file?.closeFile()
	 }
 }
```

## 파일 자르기 Truncating

```swift
 // truncateFile(atOffset:) 메소드를 사용하면 지정된 오프셋에서 파일을 자를 수 있음
 // 파일의 전체 내용을 삭제하려면 이 메서드를 호출할 때 오프셋을 0으로 지정
 let file: FileHandle? = FileHandle(forUpdatingAtPath: filePath1)
 if file == nil {
	 print("File open failed")
 } else {
	 file?.truncateFile(atOffset: 0)
	 file?.closeFile()
 }
```
</details>
