//
//  ViewController.swift
//  AutolayoutCodeDemo
//
//  Created by Minjae Kim on 11/13/23.
//

import UIKit

class ViewController: UIViewController {

	let hStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 0
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		return stack
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		configUI()
//		example01()
//		example02()
//		example03()
//		example04()
		example05()
//		example05_rev()
	}
	
	private func configUI() {
		self.view.backgroundColor = .systemBackground
		
		let myLabel = UILabel()
		myLabel.translatesAutoresizingMaskIntoConstraints = false
		myLabel.text = "My Label"
		
		let myButton = UIButton()
		myButton.translatesAutoresizingMaskIntoConstraints = false
		myButton.setTitle("My Button", for: .normal)
		myButton.configuration = .borderedProminent()
		
		self.view.addSubview(myLabel)
		self.view.addSubview(myButton)
		
		NSLayoutConstraint.activate([
			myLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			myLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			
			myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			myButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 20)
		])
	}
	private func example01() {
		let myLabel1: UILabel = {
			let label = UILabel()
			label.translatesAutoresizingMaskIntoConstraints = false
			label.text = "Hello"
			return label
		}()
		
		let myLabel2: UILabel = {
			let label = UILabel()
			label.translatesAutoresizingMaskIntoConstraints = false
			label.text = "World"
			return label
		}()
		
		self.view.addSubview(myLabel1)
		self.view.addSubview(myLabel2)
		
		NSLayoutConstraint.activate([
			myLabel1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			myLabel1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
			
			myLabel2.centerYAnchor.constraint(equalTo: myLabel1.centerYAnchor),
			myLabel2.leadingAnchor.constraint(equalTo: myLabel1.trailingAnchor, constant: 20)
		])
	}
	
	private func example02() {
		let myLabel1: UILabel = {
			let label = UILabel()
			label.translatesAutoresizingMaskIntoConstraints = false
			label.text = "Hello"
			return label
		}()
		
		let myLabel2: UILabel = {
			let label = UILabel()
			label.translatesAutoresizingMaskIntoConstraints = false
			label.text = "World"
			return label
		}()
		
		self.view.addSubview(myLabel1)
		self.view.addSubview(myLabel2)
		
		NSLayoutConstraint.activate([
			myLabel1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			myLabel1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
			
			myLabel2.centerYAnchor.constraint(equalTo: myLabel1.centerYAnchor),
			myLabel2.leadingAnchor.constraint(equalTo: myLabel1.trailingAnchor, constant: 20)
		])
	}
	
	private func example03() {
		let imageView: UIImageView = {
			let image = UIImageView(image: UIImage(named: "2Q"))
			image.contentMode = .scaleAspectFit
			image.translatesAutoresizingMaskIntoConstraints = false
			return image
		}()
		
		let myLabel: UILabel = {
			let label = UILabel()
			label.translatesAutoresizingMaskIntoConstraints = false
			label.text = "Autolayout..."
			return label
		}()
		
		self.view.addSubview(imageView)
		self.view.addSubview(myLabel)
		
		NSLayoutConstraint.activate([
			imageView.widthAnchor.constraint(equalToConstant: 100),
			imageView.heightAnchor.constraint(equalToConstant: 100),
			imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
			
			myLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
			myLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
		])
	}
	
	private func example04() {
		let myButton: UIButton = {
			let button = UIButton()
			button.translatesAutoresizingMaskIntoConstraints = false
			button.setTitle("Tap Me", for: .normal)
			button.configuration = .borderedProminent()
			return button
		}()
		
		self.view.addSubview(myButton)
		
		NSLayoutConstraint.activate([
			myButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
			myButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
			myButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
		])
	}
	
	private func example05() {
		self.view.backgroundColor = .systemBackground
		let redView: UIView = {
			let view = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.backgroundColor = .systemRed
			return view
		}()
		
		let greenView: UIView = {
			let view = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.backgroundColor = .systemGreen
			return view
		}()
		
		hStack.addArrangedSubview(redView)
		hStack.addArrangedSubview(greenView)
		self.view.addSubview(hStack)
	}
	
	override func viewWillLayoutSubviews() {
		NSLayoutConstraint.deactivate([
			hStack.topAnchor.constraint(equalTo: self.view.topAnchor),
			hStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			hStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			hStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.size.height / 3 * 2))
		])
	}
	override func viewDidLayoutSubviews() {
		NSLayoutConstraint.activate([
			hStack.topAnchor.constraint(equalTo: self.view.topAnchor),
			hStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			hStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			hStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.size.height / 3 * 2))
		])
	}
	
		func example05_rev() {
	
			let myView1 = UIView()
			myView1.translatesAutoresizingMaskIntoConstraints = false
			myView1.backgroundColor = UIColor.red
	
			let myView2 = UIView()
			myView2.translatesAutoresizingMaskIntoConstraints = false
			myView2.backgroundColor = UIColor.green
	
			self.view.addSubview(myView1)
			self.view.addSubview(myView2)
	
			let constraints = [
				myView1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.333333, constant: 0),
				myView1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
				myView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
				myView1.trailingAnchor.constraint(equalTo: self.view.centerXAnchor)
			]
	
			let constraints2 = [
				myView2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.333333, constant: 0),
				myView2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
				myView2.leadingAnchor.constraint(equalTo: self.view.centerXAnchor),
				myView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
			]
	
			NSLayoutConstraint.activate(constraints)
			NSLayoutConstraint.activate(constraints2)
		}
}

//#Preview {
//	ViewController()
//}
