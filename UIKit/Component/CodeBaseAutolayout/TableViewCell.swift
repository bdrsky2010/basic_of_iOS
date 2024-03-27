//
//  TableView.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/5/23.
//

import UIKit

class TableViewCell: UITableViewCell {
	private var userProfileImg: UIImageView = {
		let imageview = UIImageView()
		imageview.image = UIImage(named: "Jungkook")
		imageview.translatesAutoresizingMaskIntoConstraints = false
		return imageview
	}()
	private var userNameLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.numberOfLines = 1
		return view
	}()
	private var userJobLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.numberOfLines = 1
		view.textColor = .gray
		return view
	}()
	private var userContentLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.numberOfLines = 0
		return view
	}()
	private var vStack: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical // 스택뷰 정렬 방식
		view.distribution = .fillEqually // 스택뷰 공간 분배
		return view
	}()
	
	/***
	 # UITableViewCell
	 
	  - 스토리보드로 init 해줄 때와 코드베이스로 init 해줄 때의 코드 방식 좀 다르다
		- 아래 코드와 같이 구현을 해줘야 함.
	 */
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.contentView.backgroundColor = .systemBackground
		
		print("MyTableView :: init() called")
		configUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func configUI() {
		contentView.addSubview(userProfileImg)
		contentView.addSubview(vStack)
		contentView.addSubview(userContentLabel)
		
		// stackView에 subView 추가
		vStack.addArrangedSubview(userNameLabel)
		vStack.addArrangedSubview(userJobLabel)
		
		NSLayoutConstraint.activate([
			userProfileImg.widthAnchor.constraint(equalToConstant: 70),
			userProfileImg.heightAnchor.constraint(equalToConstant: 70),
			userProfileImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			userProfileImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			
			vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			vStack.leadingAnchor.constraint(equalTo: userProfileImg.trailingAnchor, constant: 10),
			vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			vStack.bottomAnchor.constraint(equalTo: userProfileImg.bottomAnchor),

			userContentLabel.topAnchor.constraint(equalTo: userProfileImg.bottomAnchor, constant: 10),
			userContentLabel.leadingAnchor.constraint(equalTo: userProfileImg.leadingAnchor),
			userContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			userContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
		])
	}
	
	func cellInit(name: String, job: String, content: String) {
		print(name)
		userNameLabel.text = name
		userJobLabel.text = job
		userContentLabel.text = content
	}
}

#Preview {
	TableViewCell()
}
