//
//  UICollectionViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/24/23.
//

import UIKit

class UICollectionViewController: UIViewController {
	
	let collectionView: UICollectionView = {
		/* Cell Layout */
		let cvLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		cvLayout.minimumLineSpacing = 10
		cvLayout.scrollDirection = .vertical
		cvLayout.itemSize = CGSize(width: 80, height: 80)
		
		/* Cell */
		let cv: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
	}
	
	private func setupView() -> Void {
		self.view.backgroundColor = UIColor.systemBackground
		
		let views: [UIView] = [collectionView]
		views.forEach { view in
			self.view.addSubview(view)
		}
		
		NSLayoutConstraint.activate([
			self.collectionView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
			self.collectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
			self.collectionView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
			self.collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
		])
	}
}

extension UICollectionViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 50
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
		cell.backgroundColor = UIColor.systemGray4
		return cell
	}
}

extension UICollectionViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("User is tapped \(indexPath.row) cell")
	}
}

#Preview {
	UICollectionViewController()
}
