import Foundation

func testDefer() {
	defer { print("defer :: first") }
	print("testDefer")
}

func testDefer2() {
	defer { print("defer :: first") }
	defer { print("defer :: second") }
	defer { print("defer :: third") }
}

func testDefer3() {
	defer {
		defer {
			defer {
				print("defer :: third")
			}
			print("defer :: second")
		}
		print("defer :: first")
	}
}

//testDefer()
//testDefer2()
testDefer3()


enum AppError: Error {
	case notConnectNetwork
	case fetchError
}

@MainActor
class ViewModel: ObservableObject {
	@Published var isLoading = false
	
	func fetch() async {
		do {
			isLoading = true
			try await checkNetworkStatus()
			try await fetchDatabase()
			defer {
				isLoading = false
			}
			
		} catch AppError.notConnectNetwork {
			// 에러 핸들링 코드
		} catch AppError.fetchError {
			// 에러 핸들링 코드
		}
	}
	
	func checkNetworkStatus() async throws {
		do {
			// 네트워크 상태를 확인하는 코드
			// ...
		} catch {
			throw AppError.notConnectNetwork
		}
	}
	
	func fetchDatabase() async throws {
		do {
			// 서버에서 데이터베이스를 불러오는 코드
			// ...
		} catch {
			throw AppError.fetchError
		}
	}
}
