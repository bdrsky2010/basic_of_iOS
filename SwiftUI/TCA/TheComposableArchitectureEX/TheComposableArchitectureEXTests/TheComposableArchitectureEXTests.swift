//
//  TheComposableArchitectureEXTests.swift
//  TheComposableArchitectureEXTests
//
//  Created by Minjae Kim on 3/15/24.
//

import XCTest
import ComposableArchitecture
@testable import TheComposableArchitectureEX

@MainActor
final class TheComposableArchitectureEXTests: XCTestCase {
	func testCounter() async {
		let store = TestStore(initialState: CounterFeature.State()) {
			CounterFeature()
		}
		
		await store.send(.incrementButtonTapped) {
			$0.count = 1
		}
		await store.send(.decrementButtonTapped) {
			$0.count = 0
		}
	}
	
	func testTimer() async {
		let clock = TestClock()
		
		let store = TestStore(initialState: CounterFeature.State()) {
			CounterFeature()
		} withDependencies: {
			$0.continuousClock = clock
		}
		
		await store.send(.toggleTimerButtonTapped) {
			$0.isTimerRunning = true
		}
		await clock.advance(by: .seconds(1))
		await store.receive(\.timerTick) {
			$0.count = 1
		}
		await store.send(.toggleTimerButtonTapped) {
			$0.isTimerRunning = false
		}
	}
	
	func testNumberFact() async {
		let store = TestStore(initialState: CounterFeature.State()) {
			CounterFeature()
		} withDependencies: {
			$0.numberFact.fetch = { "\($0) is a good number." }
		}
		
		await store.send(.factButtonTapped) {
			$0.isLoading = true
		}
		await store.receive(\.factResponse, timeout: .seconds(1)) {
			$0.isLoading = false
			$0.fact = "0 is a good number."
		}
	}
	
	func testIncrementInFirstTab() async {
		let store = TestStore(initialState: AppFeature.State()) {
			AppFeature()
		}
		
		await store.send(\.tab1.incrementButtonTapped) {
			$0.tab1.count = 1
		}
	}
	
	func testAddFlow() async {
		let store = TestStore(initialState: ContactsFeature.State()) {
			ContactsFeature()
		} withDependencies: {
			$0.uuid = .incrementing
		}
		
		await store.send(.addButtonTapped) { // 여기서 테스트 실패하는데 모르겠음
			$0.destination = .addContact(
				AddContactFeature.State(
					contact: Contact(id: UUID(0), name: "")
				)
			)
		}
		await store.send(\.destination.addContact.setName, "Blob Jr.") {
			$0.destination?.addContact?.contact.name = "Blob Jr."
		}
		await store.send(\.destination.addContact.saveButtonTapped)
		await store.receive(
			\.destination.addContact.delegate.saveContact,
			 Contact(id: UUID(0), name: "Blob Jr.")
		) {
			$0.contacts = [
				Contact(id: UUID(0), name: "Blob Jr.")
			]
		}
		await store.receive(\.destination.dismiss) {
			$0.destination = nil
		}
	}
	
	func testDeleteContact() async {
		let store = TestStore(
			initialState: ContactsFeature.State(
				contacts: [
					Contact(id: UUID(0), name: "Blob"),
					Contact(id: UUID(1), name: "Blob Jr."),
				]
			)
		) {
			ContactsFeature()
		}
		
		await store.send(.deleteButtonTapped(id: UUID(1))) {
			$0.destination = .alert(.deleteConfirmation(id: UUID(1)))
		}
		await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(1)))))) {
			$0.contacts.remove(id: UUID(1))
			$0.destination = nil
		}
	}
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
