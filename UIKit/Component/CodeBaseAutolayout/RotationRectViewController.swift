//
//  RotationRectViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/10/23.
//

import UIKit

class RotationRectViewController: UIViewController {
	let square: UIView = {
		let view: UIView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
		view.backgroundColor = .blue
		return view
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		self.view.addSubview(square)
		
		NSLayoutConstraint.activate([
			self.square.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.square.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
		])
		
		UIView.animate(withDuration: 5.0, animations: {
			self.square.backgroundColor = .red
			let rotation = CGAffineTransform(rotationAngle: 3.14)
			self.square.transform = rotation
		})
    }
}

#Preview {
	RotationRectViewController()
}
