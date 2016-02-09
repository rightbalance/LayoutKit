import XCTest
@testable import LayoutKit

class CGRectTest: XCTestCase {
	func testInsetBy() {
		let rect   = CGRect(x: 30.0, y: 40.0, width: 50.0, height: 60.0)
		let insets = LayoutInsets(top: 5.0, left: 15.0, bottom: 10.0, right: 20.0)
		XCTAssertEqual(rect.insetBy(insets), CGRect(x: 45.0, y: 45.0, width: 15.0, height: 45.0))
	}
}
