//
//  ActivityIndicatorViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/11/23.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {
	let activityIndicator: UIActivityIndicatorView = {
		let view: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
		view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		view.translatesAutoresizingMaskIntoConstraints = false
		
		// 이 코드를 줘야 돌아가는 애니메이션 작동
		view.startAnimating()
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		setView()
	}
	private func setView() {
		self.view.addSubview(activityIndicator)
		NSLayoutConstraint.activate([
			self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
		])
	}
}

#Preview {
	ActivityIndicatorViewController()
}
