//
//  ExplainFile.swift
//  FileExampleDemo
//
//  Created by Minjae Kim on 11/20/23.
//

import Foundation

/**
 # 파일 존재 여부 확인
 
 //  FileManager 인스턴스 참조
 let filemgr = FileManager.default

 // 파일 존재 여부 확인
 //  fileExists(atPath:) 메소드는 문제의 파일에 대한 경로를 포함하는 NSString 객체를 인수로 취하고 지정된 파일의 존재 여부를 나타내는 부울Boolean 값을 반환
 if filemgr.fileExists(atPath: "/Applications") {
	 print("File exists")
 } else {
	 print("File not found")
 }
 */

/**
 # 두 파일의 내용 비교
 
 // contentEqual(atPath:) 메소드는 비교할 두 파일의 경로를 인수로 사용하고 파일 내용이 일치하는지 여부를 나타내는 부울Boolean 결과를 반환
 let filePath1 = docsDir + "/myfile1.txt"
 let filePath2 = docsDir + "/myfile2.txt"

 if filemgr.contentsEqual(atPath: filePath1, andPath: filePath2) {
	 print("File contents match")
 } else {
	 print("File contents do not match")
 }
 */

/**
 # 파일이 읽기 / 쓰기 / 실행 / 삭제 가능한지 확인
 대부분의 운영체제는 일정 수준의 파일 엑세 제어를 제공
	- 일반적으로 각 사용자 또는 사용자 그룹의 파일에 대한 액세스 수준을 제어하도록 설계된 속성의 형태를 취함
 
 //  isReadableFile(atPath:), isWritableFile(atPath:), isExecutableFile(atPath:),  isDeletableFile(atPath:)  각 메서드는 확인할 파일 경로 형식의 단일 인수를 사용하고 부울 결과를 반환
 // 예를 들어 파일이 쓰기 가능한지 확인하는 코드
 if filemgr.isWritableFile(atPath: filePath1) {
	 print("File is writable")
 } else {
	 print("File is read-only")
 }
 */

/**
 # 파일 이동 / 이름 바꾸기
 
 // moveItem(atPath:) 메서드는 이동할 파일의 경로 이름과 대상 경로를 인수로 사용
 // 대상 파일 경로가 이미 존재하는 경우 이 작업은 실패
 do {
	 try filemgr.moveItem(atPath: filePath1, toPath: filePath2)
	 print("Move successful")
 } catch let error {
	 print("Error: \(error.localizedDescription)")
 }
 */

/**
 #
 */

/**
 #
 */

/**
 #
 */
