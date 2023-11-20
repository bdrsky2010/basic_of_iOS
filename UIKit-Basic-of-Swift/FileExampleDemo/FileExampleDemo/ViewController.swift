//
//  ViewController.swift
//  FileExampleDemo
//
//  Created by 박준영 on 11/20/23.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var textBox: UITextField!
	
	var fileMgr = FileManager.default
	var dataFile: String = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		checkFile()
	}
	
	// 사용자가 앱을 시작할 때마다 데이터 파일이 존재하는지 확인
	// 파일이 존재하는 경우 앱에서 콘텐츠를 읽고 텍스트 필드에 표시
	// - 사용자가 이전에 텍스트를 저장하지 않은 경우 파일이 생성되지 않음
	func checkFile() {
		
		let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
		
		// 문서 디렉토리가 어디에 있는지 알고 나면 파일이 존재하는 확인하기 전에
		// 파일(datafile.dat)의 전체(절대) 경로를 구성
		dataFile = dirPaths[0].appendingPathComponent("datafile.dat").path
		
		// 파일이 존재하는 경우 파일 내용을 읽고, 텍스트필드에 넣음
		if fileMgr.fileExists(atPath: dataFile) {
			
			if let databuffer = fileMgr.contents(atPath: dataFile) {
				let datastring = NSString(data: databuffer, encoding: String.Encoding.utf8.rawValue)
				textBox.text = datastring as String?
			}
		}
	}
	
	@IBAction func saveText(_ sender: Any) {
		// 텍스트필드 객체의 텍스트를 변환하고 이를 Data 객체에 할당
		// 그 내용을 파일 관리자 객채의 createFile() 메서드를 호출하여 파일에 기록
		if let text = textBox?.text {
			let databuffer = text.data(using: String.Encoding.utf8)
			fileMgr.createFile(atPath: dataFile, contents: databuffer, attributes: nil)
			simpleAlert("저장성공!!")
		}
	}
	
	// Alert 알림창
	func simpleAlert(_ message: String) {
		let alert = UIAlertController(title: "Save", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	/*
	 디렉토리 및 파일 예제 01
	 <현재 디렉토리>에 있는 모든 파일의 이름과 크기를 출력하는 코드를 작성해보세요.
	 */
	@IBAction func allFileSizeShow(_ sender: UIButton) {
		let currentPath = fileMgr.currentDirectoryPath
		do {
			
			let files = try fileMgr.contentsOfDirectory(atPath: currentPath)
			
			for file in files {
				// 파일 이름과 크기를 출력하는 코드를 작성하세요.
				do {
					let fileAttributes = try fileMgr.attributesOfItem(atPath: currentPath + file)
					
					if let fileSize = fileAttributes[FileAttributeKey.size] as? UInt64 {
						
						let formattedFileSize = ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
						
						print("File: \(file), Size: \(formattedFileSize)")
					}
				} catch {
					print(error)
				}
			}
		} catch {
			print(error)
		}
	}
	
	/*
	 디렉토리 및 파일 예제 02
	 특정 디렉토리에 있는 모든 <이미지> 파일을 새로운 디렉토리로 복사하는 코드를 작성해보세요.
	 
	 이미지 파일은 확장자가 .jpg, .png, .gif 인 파일로 가정합니다.
	 */
	@IBAction func fileCopy(_ sender: UIButton) {
		let sourcePath = "/Users/minjaekim/Documents/ExampleImage/"    // 예시 디렉토리
		let destinationPath = "/Users/minjaekim/Documents/Backup/" // 예시 디렉토리
		
		do {
			let files = try fileMgr.contentsOfDirectory(atPath: sourcePath)
			
			for file in files {
				// 이미지 파일을 복사하는 코드를 작성하세요.
				if file.hasSuffix("jpeg") || file.hasSuffix("jpg") || file.hasSuffix("png") || file.hasSuffix("gif") {
					// 디렉토리 경로 NSString으로 캐스팅
					let sourceFilePath = (sourcePath as NSString).appendingPathComponent(file)
					let destinationFilePath = (destinationPath as NSString).appendingPathComponent(file)
					do {
						try fileMgr.copyItem(atPath: sourceFilePath as String, toPath: destinationFilePath)
						print("Copy successful")
					} catch {
						print(error)
					}
				}
			}
		} catch {
			print(error)
		}
	}
	
	/*
	 디렉토리 및 파일 예제 03
	 특정 파일에 있는 텍스트를 역순으로 바꾸어 새로운 파일에 저장하는 코드를 작성해보세요.
	 예를 들어, 원본 파일에 "Hello World" 가 있으면, 새로운 파일에 "dlroW olleH" 가 저장되어야 합니다.
	 */
	@IBAction func fileModify(_ sender: UIButton) {
		let sourceFile = "/Users/minjaekim/Documents/text.txt"
		let destinationFile = "/Users/minjaekim/Documents/reversed.txt"
		let contents = ["How was your day? I was the best.",
						"What are you going to do? I will read a book.",
						"That’s what I’m saying. I was really surprised!",
						"I’m about to leave. Please hold for a moment.",
						"Who are you meeting today? Why are you dressed up?",
						"Do you really think so? Well, I think we need to talk about it."]
		
		if fileMgr.fileExists(atPath: sourceFile) {
			dump("File exists")
		} else {
			dump("File are found")
			createFile(atPath: sourceFile, contents: nil, attributes: nil)
		}
		
		if let dataBuffer = fileMgr.contents(atPath: sourceFile) {
			var content: String
			var newContent: String
			var newData: Data?
			
			dump(dataBuffer)
			content = String(decoding: dataBuffer, as: UTF8.self)
			dump(content)
			
			if content.isEmpty {
				dump("content is empty")
				content = contents.randomElement()!
				do {
					let sourceData = try JSONEncoder().encode(content)
					createFile(atPath: sourceFile, contents: sourceData, attributes: nil)
				} catch {
					dump(error)
				}
			}
			
			newContent = String(content.reversed())
			
			do {
				// 텍스트를 역순으로 바꾸어 저장하는 코드를 작성하세요.
				newData = try JSONEncoder().encode(newContent)
				createFile(atPath: destinationFile, contents: newData, attributes: nil)
			} catch {
				dump(error)
			}
		}
	}
	
	private func createFile(atPath: String, contents: Data?, attributes: [FileAttributeKey : Any]?) {
		fileMgr.createFile(atPath: atPath, contents: contents, attributes: attributes)
		dump("create file")
	}
	
	/*
	 디렉토리 및 파일 예제 04
	 특정 파일에 있는 숫자들을 읽어서 합계와 평균을 구하고, 그 결과를 새로운 파일에 저장하는 코드를 작성해보세요.

	 (숫자들은 한 줄에 하나씩 정수로 저장되어 있다고 가정합니다.)
	 (또는 숫자들은 ','로 구분하여 저장되어 있다고 가정합니다.)
	 */
	@IBAction func fileCalc(_ sender: UIButton) {
		let sourceFile = "/Users/user/Documents/numbers.txt"
		let destinationFile = "/Users/user/Documents/summary.txt"
		let numbers: [Int] = (0...4).map { _ in Int.random(in: 50...200) }

		if fileMgr.fileExists(atPath: sourceFile) {
			dump("File exists")
		} else {
			dump("File are found")
			createFile(atPath: sourceFile, contents: nil, attributes: nil)
		}
		
		do {
			// 숫자들의 합계와 평균을 구하고 저장하는 코드를 작성하세요.
		} catch {
			print(error)
		}
	}
	
	/*
	 디렉토리 및 파일 예제 05
	 특정 파일에 있는 텍스트를 읽어서 단어의 빈도수를 계산하고, 그 결과를 새로운 파일에 저장하는 코드를 작성해보세요.

	 단어는 공백으로 구분되며, 대소문자는 구분하지 않습니다.

	 결과는 단어와 빈도수를 콜론(:)으로 구분하고, 한 줄에 하나씩 저장합니다.

	 예를 들어, 원본 파일에 "Hello hello world" 가 있으면, 새로운 파일에 "hello:2\nworld:1" 가 저장되어야 합니다.
	 */
	@IBAction func fileFrequency(_ sender: Any) {
		dump("aa")
	}
}

