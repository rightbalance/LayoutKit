import XCTest
@testable import LayoutKit

class CGSizeTests: XCTestCase {
	func testCenteredIn() {
		let size = CGSize(width: 10.0, height: 20.0)
		
		XCTAssertEqual(
			size.centeredIn(CGRect(x: 0.0, y: 0.0, width: 20.0, height: 30.0)),
			CGRect(x: 5.0, y: 5.0, width: 10.0, height: 20.0)
		)
		
		XCTAssertEqual(
			size.centeredIn(CGRect(x: 10.0, y: 20.0, width: 5.0, height: 5.0)),
			CGRect(x: 7.5, y: 12.5, width: 10.0, height: 20.0)
		)
		
		XCTAssertEqual(
			size.centeredIn(CGRect(x: -100.0, y: -100.0, width: 200.0, height: 200.0)),
			CGRect(x: -5.0, y: -10.0, width: 10.0, height: 20.0)
		)
	}
}
