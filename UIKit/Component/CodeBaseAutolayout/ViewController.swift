//
//  ViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/4/23.
//

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// 화면 배경색 설정
		self.view.backgroundColor = .systemBackground
		self.navigationItem.title = "첫 번째 뷰"
		
		let firstView: UIView = UIView()
		firstView.translatesAutoresizingMaskIntoConstraints = false
		firstView.backgroundColor = .systemPink
		self.view.addSubview(firstView)
		
		// x축, y축 위치
		firstView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		firstView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
		
		// 뷰의 가로 세로 크기
		firstView.widthAnchor.constraint(equalToConstant: 200).isActive = true
		firstView.heightAnchor.constraint(equalToConstant: 200).isActive = true
		firstView.layer.cornerRadius = 30
		
		// 클로저로 뷰를 생성
		let secondView: UIView = {
			let view: UIView = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.backgroundColor = .systemGreen
			view.layer.cornerRadius = 15
			view.clipsToBounds = true
			return view
		}()
		
		self.view.addSubview(secondView)
		
		NSLayoutConstraint.activate ([
			secondView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 10),
			secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 50),
			secondView.widthAnchor.constraint(equalToConstant: 100),
			secondView.heightAnchor.constraint(equalToConstant: 100)
		])
		
		let thirdView: CircleView = {
			let view: CircleView = CircleView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.backgroundColor = .systemTeal
			return view
		}()
		
		self.view.addSubview(thirdView)
		
		NSLayoutConstraint.activate([
			thirdView.widthAnchor.constraint(equalTo: secondView.widthAnchor, multiplier: 1.5),
			thirdView.heightAnchor.constraint(equalTo: secondView.heightAnchor, multiplier: 1.5),
			thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 50),
			thirdView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
		])
		
		let button: UIButton = {
			let view: UIButton = UIButton()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.frame = .init()
			view.backgroundColor = .systemBlue
			view.layer.cornerRadius = 25
			view.layer.masksToBounds = true
			view.setTitle("테이블뷰로 이동", for: .normal)
			view.setTitleColor(.black, for: .highlighted)
			return view
		}()
		
		self.view.addSubview(button)
		
		NSLayoutConstraint.activate([
			button.heightAnchor.constraint(equalTo: secondView.heightAnchor, multiplier: 0.5),
			button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			button.topAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: 50)
		])
		button.addTarget(self, action: #selector(onTabButton), for: .touchUpInside)
	}
	
	@objc private func onTabButton() {
		print("버튼 눌렸다")
		self.navigationController?.pushViewController(firstTableView(), animated: true)
	}
}

#Preview {
	ViewController()
}
