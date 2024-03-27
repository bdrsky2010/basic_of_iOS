//
//  DemoProject2Tests.swift
//  DemoProject2Tests
//
//  Created by Minjae Kim on 10/20/23.
//

import XCTest
@testable import DemoProject2

final class DemoProject2Tests: XCTestCase {
	
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testExample() throws {
		let util = KUtility()
		XCTAssertEqual( util.add(1, 1), 2 )
	}
	
	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		measure {
			// Put the code you want to measure the time of here.
		}
	}
	
}
