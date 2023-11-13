//
//  ViewController.swift
//  TempConverDemo
//
//  Created by Minjae Kim on 11/13/23.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var resultLabel: UILabel!
	
	@IBOutlet weak var tempText: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	@IBAction func tapConvertTempButton(_ sender: UIButton) {
		guard let tempString = tempText.text else {
			return
		}
		
		if let fatreheit = Double(tempString) {
			let celsius = (fatreheit - 32) / 1.8
			let resultText = "celsius \(celsius)"
			resultLabel.text = resultText
		}
	}
	/**
	 키보드 숨기기

	 키보드를 숨기는 메커니즘을 추가

	 이상적으로는 사용자가 배경 보기를 터치하거나 키보드의 Return 키를 탭할 때 키보드가 보기에서 사라져야 합니다
	 (시뮬레이터에서 테스트할 때 I/O -> 키보드 -> 소프트웨어 키보드 전환 메뉴를 선택하지 않으면 키보드가 나타나지 않을 수 있다는 점에 유의하세요)
	 
	 이를 달성하기 위해 다음과 같이 ViewController.swift 파일의 뷰 컨트롤러에 touchesBegan 이벤트 핸들러 메소드를 구현
	 */
	
	// 터치 이벤트 처리
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		tempText.endEditing(true)
		
	}
	
	/**
	 Return 키를 누를 때 키보드를 숨기는 것

	 보조 편집기를 표시하고 텍스트 필드에서 마우스 오른쪽 버튼을 클릭한 후 ViewController 내의 viewDidLoad 메서드 아래 위치로 드래그

	 라인을 놓으면 연결 대화 상자의 설정을 변경하여 Type 메뉴를 UITextField로 설정하고 Did End on Exit 이벤트에 대해 textFieldReturn이라는 액션 연결을 설정하고 연결 버튼을 클릭하여 연결을 설정

	 ViewController.swift 파일을 선택하고 textFieldReturn 스텁 메소드를 찾아서 편집
	 */
	
	// UITextfield의 Did End on Exit 이벤트와 연결
	@IBAction func textfieldReturn(_ sender: UITextField) {
		sender.resignFirstResponder()
	}
	
}

