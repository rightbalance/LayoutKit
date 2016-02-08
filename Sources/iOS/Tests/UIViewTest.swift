import XCTest
@testable import LayoutKit

class UIViewTest: XCTestCase {
	func testHierarchy() {
		let superview = UIView()
		let subviews  = [UIView(), UIView()]
		
		superview.addSubview(subviews[0])
		superview.addSubview(subviews[1])
		
		XCTAssert(superview.sublayouts[0] === subviews[0])
		XCTAssert(superview.sublayouts[1] === subviews[1])
		XCTAssert(subviews[0].superlayout === superview)
		XCTAssert(subviews[1].superlayout === superview)
	}
	
	func testNaturalSize() {
		let view = StubView()
		XCTAssertEqual(view.naturalSize,                                         CGSize(width: 100.0, height: 20.0))
		XCTAssertEqual(view.naturalSizeConstrainedBy(width: 50.0, height: nil),  CGSize(width: 50.0,  height: 20.0))
		XCTAssertEqual(view.naturalSizeConstrainedBy(width: nil,  height: 50.0), CGSize(width: 100.0, height: 50.0))
	}
}

private class StubView: UIView {
	private override func intrinsicContentSize() -> CGSize {
		return CGSize(width: 100.0, height: 20.0)
	}
}
