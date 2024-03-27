//
//  AlertViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/12/23.
//

import UIKit
/**
 # UIAlertController
 
 - 사용자에게 경고 메시지를 띄어주거나
 - 사용자가 이에 대한 응답할 수 있는 방법을 제공
	- addAction(_ action: ) 메서드를 통해 각 작업에 대해 응답할 수 있는 버튼을 생성
	- 위의 action 매개변수는 UIAlertAction 프로토콜을 따르고 있으며
	- UIAlertAction을 init 할 때는 UIAlertAction(title: , style: , handler: )
		- title: String?
		- style: UIAlertAction.Style
		- handler: ((UIAlertAction) -> Void)?
 
 - textfield를 추가해줄 수 있음
 - addTextField(configurationHandler: ((UITextField) -> Void)?) 를 통해 textfield 추가
 - textfield는 1개 이상 추가해줄 수 있으며 해당 textfield의 text값에 접근이 가능하고
 - textfield는 alertController에 배열로 저장된다
 */
class AlertViewController: UIViewController {
	let alert: UIAlertController = {
		let view = UIAlertController(title: "위치정보제공동의", message: "동의해주실래용?", preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: "동의", style: .default, handler: { action in
			
		})
		let destructiveAction = UIAlertAction(title: "비동의", style: .destructive, handler: { action in
			
		})
		view.addAction(defaultAction)
		view.addAction(destructiveAction)
		return view
	}()
	
	let textfieldAlert: UIAlertController = {
		let view = UIAlertController(title: "마음의 편지", message: "진짜 보낼거야?", preferredStyle: .alert)
		let destructiveAction = UIAlertAction(title: "취소", style: .destructive, handler: { action in
			
		})
		view.addTextField { textfield in
			textfield.placeholder = "맘껏 적어요.."
		}
		view.addAction(destructiveAction)
		return view
	}()
	
	let alertSheet: UIAlertController = {
		let view = UIAlertController(title: "삭제", message: "삭제하시겠습니까?", preferredStyle: .actionSheet)
		let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: { action in
			
		})
		let destructiveAction = UIAlertAction(title: "삭제", style: .destructive, handler: { action in
			
		})
		view.addAction(cancelAction)
		view.addAction(destructiveAction)
		return view
	}()
	
	let alertButton: UIButton = {
		let view = UIButton()
		view.setTitle("Alert", for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.configuration = .borderedTinted()
		return view
	}()
	
	let textfieldAlertButton: UIButton = {
		let view = UIButton()
		view.setTitle("Alert Textfield", for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.configuration = .borderedProminent()
		return view
	}()
	
	let alertSheetButton: UIButton = {
		let view = UIButton()
		view.setTitle("Alert Sheet", for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.configuration = .bordered()
		return view
	}()
	
	let label: UILabel = {
		let view = UILabel()
		view.numberOfLines = .zero
		view.font = .systemFont(ofSize: 20)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		configUI()
		
		self.alertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
		self.textfieldAlertButton.addTarget(self, action: #selector(showTextfieldAlert), for: .touchUpInside)
		self.alertSheetButton.addTarget(self, action: #selector(showAlertSheet), for: .touchUpInside)
    }
	private func configUI() {
		let defaultAction = UIAlertAction(title: "보내기", style: .default, handler: { _ in
			self.label.text = self.textfieldAlert.textFields?[0].text
			self.textfieldAlert.textFields?[0].text = ""
		})
		self.textfieldAlert.addAction(defaultAction)
		
		self.view.addSubview(self.alertButton)
		self.view.addSubview(self.textfieldAlertButton)
		self.view.addSubview(self.alertSheetButton)
		self.view.addSubview(self.label)
		
		NSLayoutConstraint.activate([
			self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
			self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
			self.label.bottomAnchor.constraint(equalTo: self.alertButton.topAnchor, constant: -10),
			
			self.alertButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.alertButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			
			self.textfieldAlertButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.textfieldAlertButton.topAnchor.constraint(equalTo: self.alertButton.bottomAnchor, constant: 10),
			
			self.alertSheetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.alertSheetButton.topAnchor.constraint(equalTo: self.textfieldAlertButton.bottomAnchor, constant: 10)
		])
	}
	
	@objc
	private func showAlert() {
		self.present(self.alert, animated: true)
	}
	@objc
	private func showTextfieldAlert() {
		self.present(self.textfieldAlert, animated: true)
	}
	@objc
	private func showAlertSheet() {
		self.present(self.alertSheet, animated: true)
	}
}
#Preview {
	AlertViewController()
}
