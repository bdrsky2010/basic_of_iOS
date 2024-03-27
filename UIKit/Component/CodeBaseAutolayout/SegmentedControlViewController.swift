//
//  SegmentedControlViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/10/23.
//

import UIKit

class SegmentedControlViewController: UIViewController {
	
	let segmentedControl: UISegmentedControl = {
		let segmentedItems: [String] = ["한국음식", "서양음식", "중국음식", "일본음식"]
		let control: UISegmentedControl = UISegmentedControl(items: segmentedItems)
		control.translatesAutoresizingMaskIntoConstraints = false
		return control
	}()
	
	//Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupView()
	}
	
	private func setupView() -> Void {
		self.view.backgroundColor = UIColor.systemBackground
		self.view.addSubview(segmentedControl)
		
		segmentedControl.addTarget(self, action: #selector(changeSegmentedView(ofSegment:)), for: .valueChanged)
		segmentedControl.selectedSegmentIndex = 0
		changeSegmentedView(ofSegment: self.segmentedControl)
		
		NSLayoutConstraint.activate([
			self.segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
			self.segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.segmentedControl.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -40),
			self.segmentedControl.heightAnchor.constraint(equalToConstant: 30)
		])
	}
	
	@objc func changeSegmentedView(ofSegment: UISegmentedControl) -> Void {
		let segmentedIndex: Int = ofSegment.selectedSegmentIndex
		switch segmentedIndex {
			case 0:
				self.view.backgroundColor = UIColor.systemRed
			case 1:
				self.view.backgroundColor = UIColor.systemBrown
			case 2:
				self.view.backgroundColor = UIColor.systemBlue
			default:
				self.view.backgroundColor = UIColor.systemBackground
		}
	}
}

#Preview {
	SegmentedControlViewController()
}
