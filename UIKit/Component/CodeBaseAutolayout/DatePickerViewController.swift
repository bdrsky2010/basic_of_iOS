//
//  DatePickerViewController.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/12/23.
//

import UIKit

class DatePickerViewController: UIViewController {
	private var datePicker: UIDatePicker = {
		let datePicker = UIDatePicker()
		datePicker.translatesAutoresizingMaskIntoConstraints = false
		
		/*
		 어떤 걸 보여줄 것인지 설정
		 - countDownTimer
		 - date
		 - time
		 - dateAndTime
		 */
		datePicker.datePickerMode = .dateAndTime
		
		// 언어 설정
		datePicker.locale = Locale(identifier: "ko-KR")
		
		// 현재 날짜
		let now = Date()
		// datePicker의 minimum을 오늘로 설정
		datePicker.minimumDate = now
		
		// 며칠을 활성화 할 건지 설정
		var dateComponents = DateComponents()
		dateComponents.day = 9
		
		// 몇 일부터 몇 일까지 잡아줄 것인지 설정
		let fewDaysFromNow = Calendar.current.date(byAdding: .day, value: dateComponents.day ?? 7, to: now)
		// 위에서 잡아준 값으로 datePicker의 maximum 값 설정
		datePicker.maximumDate = fewDaysFromNow
		
		// 몇 분 단위로 점프점프 할 것인지
		datePicker.minuteInterval = 2
		
		return datePicker
	}()
	
	lazy var dateFormmater: DateFormatter = {
		let dateFormmater = DateFormatter()
		
		dateFormmater.dateStyle = .medium // 날짜 디테일 정도 정해줌
		dateFormmater.timeStyle = .short // 시간 디테일 정도 정해줌
		
		return dateFormmater
	}()
	
	private var dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		return label
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		configureDatePicker()
    }
	
	private func configureDatePicker() {
		// 알아서 화면 사이즈에 맞게 수직 사이즈를 조절해준다
		self.datePicker.preferredDatePickerStyle = traitCollection.verticalSizeClass == .compact ? .compact : .inline
		self.datePicker.addTarget(self, action: #selector(updateDatePickerLabel), for: .valueChanged)
		
		updateDatePickerLabel()
		
		self.view.addSubview(self.datePicker)
		self.view.addSubview(self.dateLabel)
		
		NSLayoutConstraint.activate([
			self.datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.datePicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			
			self.dateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.dateLabel.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 20)
		])
	}
	
	@objc
	func updateDatePickerLabel() {
		dateLabel.text = dateFormmater.string(from: self.datePicker.date)
		
		Swift.debugPrint("Chosen date: \(dateFormmater.string(from: self.datePicker.date))")
	}
}

#Preview {
	DatePickerViewController()
}
