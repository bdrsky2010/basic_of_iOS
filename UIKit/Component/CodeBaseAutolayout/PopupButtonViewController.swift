//
//  PopupButtonViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/10/23.
//
import UIKit
/**
 # Popup Menu(UIMenu) 가이드
 
 - 작업 목록 제공
 - 사용자가 여러 항목을 선택할 수 있도록
 - 서브 메뉴를 포함하고 있을 때
 
 - 선택한 내용을 사용자가 알아볼 수 있도록 레이블에 업데이트 해줘야 하며
 - 사용자가 선택하지 않은 경우 기본값에 대한 항목으로 표시
 
 - 공간이 한정되어 있고 모든 옵션을 보여줄 필요가 없는 경우 팝업 버튼 추천
 - 공간에 효율적인 방법
 */
class PopupButtonViewController: UIViewController {
	let popupButton: UIButton = {
		let btn: UIButton = UIButton(primaryAction: nil)
		btn.configuration = .bordered()
		btn.showsMenuAsPrimaryAction = true
		btn.changesSelectionAsPrimaryAction = true
		btn.translatesAutoresizingMaskIntoConstraints = false
		return btn
	}()
	
	let uiActionHander = { (action: UIAction) in
		print(action.title)
	}
	
	//Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupView()
	}
	
	private func setupView() -> Void {
		self.view.backgroundColor = UIColor.systemBackground
		self.view.addSubview(popupButton)
		self.popupButton.menu = UIMenu(title: "Sort", children: [
			UIAction(title: "title", handler: uiActionHander),
			UIAction(title: "Recently Added", handler: uiActionHander),
			UIAction(title: "Recently Played", handler: uiActionHander),
			UIAction(title: "Playlist Type", handler: uiActionHander)
		])
		
		NSLayoutConstraint.activate([
			self.popupButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.popupButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
		])
	}
}

#Preview {
	PopupButtonViewController()
}
