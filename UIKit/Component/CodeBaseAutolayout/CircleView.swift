//
//  CircleView.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/5/23.
//

import UIKit

class CircleView: UIView {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		print("CircleView :: layoutSubviews() called")
		self.layer.cornerRadius = self.frame.height / 2
	}
}
