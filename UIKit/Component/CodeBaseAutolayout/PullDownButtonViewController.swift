//
//  PullDownMenuButtonViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/10/23.
//
/**
 # Pull Down Menu(UIMenu) 가이드
 - 모든 작업을 메뉴에 넣게되면 사용자들이 작업을 수행하기 위해서는 길게 or 적어도 두 번 탭해야 하므로 모든 기능 넣는것을 지양
 
 - 메뉴를 사용하여 작업과 직접 관련된 옵션을 표출
	- 추가 버튼을 탭 -> 추가 할 항목을 지정할 수 있는 메뉴
	- 앱이 정렬을 지원 -> 메뉴를 사용하여 사용자들이 정렬 할 속성을 선택 가능
 
 - 그룹화된 메뉴를 사용하여 보조 앱 작업을 제공
 
 - 메뉴를 표시할땐 '원형 버튼 안에 줄임표 기호'이미지로 추가 버튼을 사용
 
 - separator 를 사용하여 관련 메뉴 항목을 시각적으로 그룹화
	- 시각적 그룹화를 만들면 사용자들이 메뉴를 더욱 빠르게 검색 가능
	- 단, 메뉴에서 세 개 이상의 그룹을 사용하면 구문 분석이 어려워 지는점 주의
 
 - 메뉴 항목이 destructive할 경우, 의도를 확인하고 요청
	- 빨간색 텍스트를 통해 destructive를 알리고, 누를경우 확인/취소 옵션을 주는 action sheet를 표출
 
 - 메뉴에서 glyph인 SF symbol을 사용하여 친숙한 경험 제공

 */
import UIKit

class PullDownButtonViewController: UIViewController {
	// 작업 목록을 제공하거나
	// 여러 항목을 선택하거나
	// 하위메뉴를 제공하는 경우
	// pull down menu를 사용
	let pullDownButton: UIButton = {
		let button: UIButton = UIButton(primaryAction: nil)
		button.setTitle("Pull Down Menu", for: .normal)
		button.showsMenuAsPrimaryAction = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
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
		self.view.addSubview(pullDownButton)
		self.pullDownButton.menu = UIMenu(title: "내일 할 일", children: [
			UIAction(title: "공부", handler: uiActionHander),
			UIAction(title: "밥먹기", handler: uiActionHander),
			UIAction(title: "산책하기", handler: uiActionHander),
			UIAction(title: "깃허브 커밋", handler: uiActionHander),
			UIAction(title: "블로그 정리", handler: uiActionHander)
		])
		
		NSLayoutConstraint.activate([
			self.pullDownButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.pullDownButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
		])
	}
}
#Preview {
	PullDownButtonViewController()
}
