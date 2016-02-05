import XCTest
@testable import LayoutKit

class LayoutTypeTest: XCTestCase {
	func testBounds() {
		let layout = StubLayout(frame: CGRect(x: 10.0, y: 20.0, width: 100.0, height: 150.0))
		XCTAssertEqual(layout.bounds,  CGRect(x:  0.0, y:  0.0, width: 100.0, height: 150.0))
	}
	
	func testCenterInSuperlayout() {
		let (_, sublayout) = stubSuperlayout(superframe: CGRect(x: 20.0, y: 40.0, width: 120.0, height: 80.0))
		sublayout.centerInSuperlayout(width: .Amount(50.0), height: .Ratio(0.5))
		XCTAssertEqual(sublayout.frame, CGRect(x: 35.0, y: 20.0, width: 50.0, height: 40.0))
	}
	
	func testCenterInRect() {
		let layout = StubLayout()
		layout.centerIn(CGRect(x: 10.0, y: 50.0, width: 90.0, height: 60.0), width: .Ratio(0.2), height: .Amount(20.0))
		XCTAssertEqual(layout.frame, CGRect(x: 46.0, y: 70.0, width: 18.0, height: 20.0))
	}
	
	func testAnchorInSuperlayout() {
		let (_, sublayout) = stubSuperlayout(superframe: CGRect(x: 5.0, y: 10.0, width: 80.0, height: 40.0))
		sublayout.anchorInSuperlayout(x: .Ratio(0.25), y: .Amount(20.0), width: .Ratio(0.5), height: .Amount(10.0))
		XCTAssertEqual(sublayout.frame, CGRect(x: 10.0, y: 20.0, width: 40.0, height: 10.0))
	}
}

extension LayoutTypeTest {
	private func stubSuperlayout(superframe superframe: CGRect = CGRect(), subframe: CGRect = CGRect()) -> (superlayout: StubLayout, sublayout: StubLayout) {
		let superlayout        = StubLayout(frame: superframe, superlayout: nil)
		let sublayout          = StubLayout(frame: subframe,   superlayout: superlayout)
		superlayout.sublayouts = [sublayout]
		return (superlayout, sublayout)
	}
}

class StubLayout: LayoutType {
	var frame = CGRect()
	var superlayout: LayoutType?
	var sublayouts = [LayoutType]()
	
	init(frame: CGRect = CGRect(), superlayout: LayoutType? = nil, sublayouts: [LayoutType] = []) {
		self.frame       = frame
		self.superlayout = superlayout
		self.sublayouts  = sublayouts
	}
}
