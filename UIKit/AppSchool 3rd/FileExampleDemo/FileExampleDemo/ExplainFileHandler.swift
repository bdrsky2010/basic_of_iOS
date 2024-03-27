//
//  ExplainFileHandler.swift
//  FileExampleDemo
//
//  Created by Minjae Kim on 11/20/23.
//

import Foundation

/**
 # FileManager로 파일 읽기 및 쓰기

 FileManager 클래스에는 몇 가지 기본 파일 읽기 및 쓰기 기능이 포함
	- FileHandle 클래스에서 제공하는 옵션에 비해 다소 제한적
 
 // content(atPath:) 메소드를 사용하여 파일의 내용을 읽고 Data 객체에 저장
 let databuffer = filemgr.contents(atPath: filePath1)

 // Data 객체에 파일 내용을 저장한 후 해당 데이터는 createFile(atPath:) 메서드를 사용하여 새 파일에 기록
 filemgr.createFile(atPath: filePath2, contents: databuffer,
					attributes: nil)
 
	- 기본적으로 기존 파일의 내용을 새 파일로 복사
	- 읽거나 쓸 데이터의 양을 제어할 수 없으며 기존 파일의 끝에 데이터를 추가하는 것을 허용하지 않음
	- 파일이 이미 존재하는 경우 해당 파일에 포함된 모든 데이터는 소스 파일의 내용으로 덮어쓰여짐
	- 좀 더 유연한 메커니즘이 필요하면 . Foundation Framework이 제공하는 FileHandle 클래스를 이용
 */

/**
 # FileHandle 클래스를 사용하여 파일 작업하기
 
 FileHandle 객체 생성
 
 // FileHandle 객체는 읽기, 쓰기 또는 업데이트(즉, 읽기 및 쓰기 모두)를 위해 파일을 열 때 생성
 // 파일을 연 후 closeFile 메소드를 사용하여 작업을 마친 후에는 파일을 닫아야함
 // 존재하지 않는 파일을 읽기 위해 열려고 하여 파일 열기 시도가 실패하는 경우  메서드는 nil을 반환
 let file: FileHandle? = FileHandle(forReadingAtPath: filePath1)
 if file == nil {
	 print("File open failed")
 } else {
	 file?.closeFile()
 }
 */

/**
 # FileHandle 파일 오프셋 및 탐색
 
 FileHandle 객체는 파일의 현재 위치에 대한 포인터를 유지(오프셋)
 
  - 파일이 처음 열릴 때 오프셋은 0(파일의 시작 부분)으로 설정
  - FileHandle 인스턴스 메서드를 사용하여 수행된 모든 읽기 또는 쓰기 작업은 파일의 오프셋 0에서 발생
  - 따라서 파일의 다른 위치에서 작업을 수행하려면 먼저 필요한 오프셋을 이동
  - 예: 파일 끝에 데이터 추가, 현재 오프셋을 파일 끝으로 이동하려면eekToEndOfFile 메소드를 사용
	- seek(toFileOffset:)을 사용하면 파일에서 오프셋이 배치될 정확한 위치를 지정
	- offsetInFile 메소드를 사용하여 현재 오프셋을 식별
	- 오프셋은 대용량 파일을 수용할 수 있도록 부호 없는 64비트 정수로 저장
 
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
 */

/**
 # 파일에서 데이터 읽기
 
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
 */

/**
 # 파일에 데이터 쓰기
 
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
 */

/**
 # 파일 자르기 Truncating
 
 // truncateFile(atOffset:) 메소드를 사용하면 지정된 오프셋에서 파일을 자를 수 있음
 // 파일의 전체 내용을 삭제하려면 이 메서드를 호출할 때 오프셋을 0으로 지정
 let file: FileHandle? = FileHandle(forUpdatingAtPath: filePath1)
 if file == nil {
	 print("File open failed")
 } else {
	 file?.truncateFile(atOffset: 0)
	 file?.closeFile()
 }
 */
