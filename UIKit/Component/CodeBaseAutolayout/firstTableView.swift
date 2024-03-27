//
//  firstTableView.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/7/23.
//

import UIKit

class firstTableView: UIViewController {
	
	lazy var myTableView: UITableView = {
		let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
		
		// 테이블뷰에 난 이 모양의 셀을 사용할거다 라고 등록해주는 코드
		// TableViewCell 클래스에서 init시 정의해준 Identifier 즉 id값을 사용
		tableView.register(TableViewCell.self, forCellReuseIdentifier: "JungkookTableViewCell")
		tableView.backgroundColor = .systemBackground
		tableView.rowHeight = UITableView.automaticDimension
		
		// 아주 중요
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()
	private var userData: [UserData] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		self.title = "이 사람의 이름은 정국입니다."
		
		view.addSubview(myTableView)
		myTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			myTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			myTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			myTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
		])
		
		userData = loadJson("data.json")

		func loadJson<T: Decodable>(_ filename: String) -> T {
			let data: Data
			
			guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
			else { fatalError("\(filename) not found") }
			
			do {
				data = try Data(contentsOf: file)
			} catch {
				fatalError("Could not load \(filename): \(error)")
			}
			
			do {
				return try JSONDecoder().decode(T.self, from: data)
			} catch {
				fatalError("Unable to parse \(filename): \(error)")
			}
		}
		print("userData.count :: \(userData.count)")
	}
}

extension firstTableView: UITableViewDelegate, UITableViewDataSource {
	// 테이블 뷰 셀의 갯수
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.userData.count
	}
	// 각 셀에 대한 설정
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// dequeueReusableCell 은 셀을 재사용해주기 위함
		let cell = tableView.dequeueReusableCell(withIdentifier: "JungkookTableViewCell", for: indexPath) as! TableViewCell
		cell.cellInit(name: userData[indexPath.row].userName, job: userData[indexPath.row].userJob, content: userData[indexPath.row].userContent)
		return cell
	}
	
	// 셀의 height값을 가변적으로 줄 때 대략 이 return 값 정도는 쓸거다 라고 정의
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}
}

#Preview {
	firstTableView()
}
