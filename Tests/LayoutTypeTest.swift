import XCTest
@testable import LayoutKit

class LayoutTypeTest: XCTestCase {
	func testBounds() {
		let layout = StubLayout(frame: CGRect(x: 10.0, y: 20.0, width: 100.0, height: 150.0))
		XCTAssertEqual(layout.bounds,  CGRect(x:  0.0, y:  0.0, width: 100.0, height: 150.0))
	}
	
	func testCenterInSuperlayout() {
		let (_, sublayout) = stubSuperlayout(superframe: CGRect(x: 20.0, y: 40.0, width: 120.0, height: 80.0))
		sublayout.centerInSuperlayout(width: .Amount(50.0), height: .Amount(30.0))
		XCTAssertEqual(sublayout.frame, CGRect(x: 35.0, y: 25.0, width: 50.0, height: 30.0))
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
