//
//  ConcurrencyView5.swift
//  DemoProject2
//
//  Created by Minjae Kim on 10/19/23.
//

import SwiftUI

struct ConcurrencyView5: View {
	var body: some View {
		Button(action: {
			// 동기 함수에서 비동기 함수 호출
			Task {
				await doSomething()
			}
		}, label: {
			Text("Do Something")
		})
	}
	
	// 작업 그룹
	// 동적인 조건에 따라 여러 작업을 동시에 생성하고 실행해야 하는 상황
	// withTaskGroup() 함수 이용
	// addTask() 함수를 호출하여 각각의 새로운 작업을 추가
	// cancelAll() 그룹의 모든 작업을 취하는 메서드
	// isCancelled 작업 그룹이 이미 취소되었는지 여부를 확인하는 속성
	// IsEmpty 작업 그룹 내에 작업이 남아 있는지 여부를 확인하는 속성
	// 데이터 경쟁 피하기
	// 동시에 데이터에 접근하는 여러 작업은 데이터 경쟁(Data Race) 조건이 발생할 위험이 있음
	// 여러 작업이 동시에 동일한 데이터에 접근하려고 시도하면 데이터 오류가 발생
	func doSomething() async {
		var timeStamps: [Int:Date] = [:]
		
		print("Start \(Date())")
		
		// 반환 타입을 변경 : Void.selt -> (Int, Date)
		await withTaskGroup(of: (Int, Date).self) { group in
			for i in 1...5 {
				group.addTask {
					return (i, await takeTooLong())
				}
			}
			
			// for-await 표현식을 사용하여 비동기적으로 반환되는 일련의 값을 루프
			// 동시 작업에서 반환되는 값의 수신을 기다려서 처리
			// 일련의 데이터가 AsyncSequence 프로토콜 준수가 필수 요구사항
			for await (task, data) in group {
				timeStamps[task] = data
			}
		}
		
		// 작업 그룹이 종료된 후 저장된 timeStamps 딕셔너리 항목을 출력
		for (task, data) in timeStamps {
			print("Task = \(task), Date = \(data)")
		}
		
		print("End \(Date())")
	}
	
	func takeTooLong() async -> Date {
		sleep(5)            // 5초 지연
		return Date()
	}
}

#Preview {
    ConcurrencyView5()
}
