import XCTest
@testable import LayoutKit

class CGSizeTest: XCTestCase {
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
	
	func testAnchoredIn() {
		let size = CGSize(width: 20.0, height: 10.0)
		
		XCTAssertEqual(
			size.anchoredIn(CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0), x: .Ratio(0.0), y: .Ratio(0.0)),
			CGRect(x: 0.0, y: 0.0, width: 20.0, height: 10.0)
		)
		
		XCTAssertEqual(
			size.anchoredIn(CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0), x: .Ratio(0.5), y: .Ratio(0.5)),
			CGRect(x: 5.0, y: 10.0, width: 20.0, height: 10.0)
		)
		
		XCTAssertEqual(
			size.anchoredIn(CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0), x: .Ratio(1.0), y: .Ratio(1.0)),
			CGRect(x: 10.0, y: 20.0, width: 20.0, height: 10.0)
		)
		
		XCTAssertEqual(
			size.anchoredIn(CGRect(x: -50.0, y: 50.0, width: 40.0, height: 40.0), x: .Ratio(0.0), y: .Ratio(1.0)),
			CGRect(x: -50.0, y: 80.0, width: 20.0, height: 10.0)
		)
		
		XCTAssertEqual(
			size.anchoredIn(CGRect(x: -50.0, y: 50.0, width: 40.0, height: 40.0), x: .Ratio(1.0), y: .Ratio(0.5)),
			CGRect(x: -30.0, y: 65.0, width: 20.0, height: 10.0)
		)
	}
	
	func testAnchoredTo() {
		let size = CGSize(width: 30.0, height: 40.0)
		let rect = CGRect(x: 10.0, y: -10.0, width: 50.0, height: 80.0)
		
		// Top:
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Top, parallelAnchor: .Ratio(0.0), perpendicularAnchor: .Ratio(0.0)),
			CGRect(x: 10.0, y: -50.0, width: 30.0, height: 40.0)
		)
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Top, parallelAnchor: .Ratio(0.5), perpendicularAnchor: .Ratio(-0.5)),
			CGRect(x: 20.0, y: -30.0, width: 30.0, height: 40.0)
		)
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Top, parallelAnchor: .Ratio(1.0), perpendicularAnchor: .Ratio(1.0)),
			CGRect(x: 30.0, y: -90.0, width: 30.0, height: 40.0)
		)
		
		// Bottom:
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Bottom, parallelAnchor: .Ratio(0.0), perpendicularAnchor: .Ratio(0.0)),
			CGRect(x: 10.0, y: 70.0, width: 30.0, height: 40.0)
		)
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Bottom, parallelAnchor: .Ratio(0.5), perpendicularAnchor: .Ratio(-0.5)),
			CGRect(x: 20.0, y: 50.0, width: 30.0, height: 40.0)
		)
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Bottom, parallelAnchor: .Ratio(1.0), perpendicularAnchor: .Ratio(1.0)),
			CGRect(x: 30.0, y: 110.0, width: 30.0, height: 40.0)
		)
		
		// Left:
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Left, parallelAnchor: .Ratio(0.0), perpendicularAnchor: .Ratio(0.0)),
			CGRect(x: -20.0, y: -10.0, width: 30.0, height: 40.0)
		)
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Left, parallelAnchor: .Ratio(0.5), perpendicularAnchor: .Ratio(-0.5)),
			CGRect(x: -5.0, y: 10.0, width: 30.0, height: 40.0)
		)
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Left, parallelAnchor: .Ratio(1.0), perpendicularAnchor: .Ratio(1.0)),
			CGRect(x: -50.0, y: 30.0, width: 30.0, height: 40.0)
		)
		
		// Right:
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Right, parallelAnchor: .Ratio(0.0), perpendicularAnchor: .Ratio(0.0)),
			CGRect(x: 60.0, y: -10.0, width: 30.0, height: 40.0)
		)
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Right, parallelAnchor: .Ratio(0.5), perpendicularAnchor: .Ratio(-0.5)),
			CGRect(x: 45.0, y: 10.0, width: 30.0, height: 40.0)
		)
		
		XCTAssertEqual(
			size.anchoredTo(rect, edge: .Right, parallelAnchor: .Ratio(1.0), perpendicularAnchor: .Ratio(1.0)),
			CGRect(x: 90.0, y: 30.0, width: 30.0, height: 40.0)
		)
	}
}
