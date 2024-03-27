//
//  ToggleViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/10/23.
//

import UIKit

class ToggleViewController: UIViewController {
	
	// 토글의 타입은 UISwitch 타입
	// 토글 선언부
	let toggleButton: UISwitch = {
		let btn: UISwitch = UISwitch()
		// 스토리보드에서 제약조건 주는 거 flase 줘서 해제
		btn.translatesAutoresizingMaskIntoConstraints = false
		return btn
	}()
	
	//Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupView()
	}
	
	// 뷰 설정 메서드
	private func setupView() -> Void {
		self.view.backgroundColor = UIColor.systemBackground
		// 루트뷰에 서브뷰로 토글 버튼 추가
		self.view.addSubview(toggleButton)
		
		let toggleIsOn: Bool = false
		// 토글 버튼 세팅
		self.toggleButton.setOn(toggleIsOn, animated: true)
		// 토글 버튼을 눌렀을 때 호출되는 메서드
		self.toggleButton.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
		// 토글 제약조건
		NSLayoutConstraint.activate([
			self.toggleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.toggleButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
		])
	}
	// 토글 버튼의 action 함수
	@objc func toggleSwitch() -> Void {
		let toggle = self.toggleButton.isOn
		print(toggle)
	}
}

#Preview {
	ToggleViewController()
}
