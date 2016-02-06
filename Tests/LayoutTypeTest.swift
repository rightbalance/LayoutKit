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
		
		sublayout.naturalSize = CGSize(width: 10.0, height: 20.0)
		sublayout.centerInSuperlayout()
		XCTAssertEqual(sublayout.frame, CGRect(x: 55.0, y: 30.0, width: 10.0, height: 20.0))
	}
	
	func testCenterInRect() {
		let layout = StubLayout()
		let rect   = CGRect(x: 10.0, y: 50.0, width: 90.0, height: 60.0)
		layout.centerIn(rect, width: .Ratio(0.2), height: .Amount(20.0))
		XCTAssertEqual(layout.frame, CGRect(x: 46.0, y: 70.0, width: 18.0, height: 20.0))
		
		layout.naturalSize = CGSize(width: 100.0, height: 200.0)
		layout.centerIn(rect)
		XCTAssertEqual(layout.frame, CGRect(x: 5.0, y: -20.0, width: 100.0, height: 200.0))
	}
	
	func testAnchorInSuperlayout() {
		let (_, sublayout) = stubSuperlayout(superframe: CGRect(x: 5.0, y: 10.0, width: 80.0, height: 40.0))
		sublayout.anchorInSuperlayout(x: .Ratio(0.25), y: .Amount(20.0), width: .Ratio(0.5), height: .Amount(10.0))
		XCTAssertEqual(sublayout.frame, CGRect(x: 10.0, y: 20.0, width: 40.0, height: 10.0))
		
		sublayout.naturalSize = CGSize(width: 50.0, height: 70.0)
		sublayout.anchorInSuperlayout(x: .Amount(10.0), y: .Ratio(1.0))
		XCTAssertEqual(sublayout.frame, CGRect(x: 10.0, y: -30.0, width: 50.0, height: 70.0))
	}
	
	func testAnchorInRect() {
		let layout = StubLayout()
		let rect   = CGRect(x: 40.0, y: 60.0, width: 100.0, height: 40.0)
		layout.anchorIn(rect, x: .Ratio(1.0), y: .Ratio(0.75), width: .Ratio(0.25), height: .Amount(20.0))
		XCTAssertEqual(layout.frame, CGRect(x: 115.0, y: 75.0, width: 25.0, height: 20.0))
		
		layout.naturalSize = CGSize(width: 20.0, height: 30.0)
		layout.anchorIn(rect, x: .Ratio(-0.5), y: .Amount(10.0))
		XCTAssertEqual(layout.frame, CGRect(x: 0.0, y: 70.0, width: 20.0, height: 30.0))
	}
	
	func testAnchorToSuperlayout() {
		let (_, sublayout) = stubSuperlayout(superframe: CGRect(x: -20.0, y: -10.0, width: 40.0, height: 10.0))
		sublayout.anchorToSuperlayout(edge: .Bottom, parallelAnchor: .Ratio(1.0), perpendicularAnchor: .Ratio(0.5), width: .Amount(30.0), height: .Ratio(1.0))
		XCTAssertEqual(sublayout.frame, CGRect(x: 10.0, y: 15.0, width: 30.0, height: 10.0))
		
		sublayout.naturalSize = CGSize(width: 30.0, height: 40.0)
		sublayout.anchorToSuperlayout(edge: .Right, parallelAnchor: .Amount(5.0), perpendicularAnchor: .Amount(20.0))
		XCTAssertEqual(sublayout.frame, CGRect(x: 60.0, y: 5.0, width: 30.0, height: 40.0))
	}
	
	func testAnchorToRect() {
		let layout = StubLayout()
		let rect   = CGRect(x: 50.0, y: 30.0, width: 10.0, height: 20.0)
		layout.anchorTo(rect, edge: .Left, parallelAnchor: .Ratio(0.0), perpendicularAnchor: .Ratio(0.25), width: .Ratio(0.6), height: .Ratio(2.0))
		XCTAssertEqual(layout.frame, CGRect(x: 42.5, y: 30.0, width: 6.0, height: 40.0))
		
		layout.naturalSize = CGSize(width: 50.0, height: 40.0)
		layout.anchorTo(rect, edge: .Top, parallelAnchor: .Amount(15.0), perpendicularAnchor: .Amount(-25.0))
		XCTAssertEqual(layout.frame, CGRect(x: 65.0, y: 15.0, width: 50.0, height: 40.0))
	}
	
	func testDistributeInSuperlayout() {
		let superlayout = stubSublayouts(sublayoutCount: 3, superframe: CGRect(x: 20.0, y: 30.0, width: 100.0, height: 50.0))
		let sublayouts  = superlayout.sublayouts
		
		superlayout.sublayouts.distributeInSuperlayout(axis: .Horizontal, spacing: 4.0, margin: LayoutInsets(top: 5.0, left: 6.0, bottom: 7.0, right: 8.0))
		
		XCTAssertEqual(sublayouts[0].frame, CGRect(x:  6.0, y: 5.0, width: 26.0, height: 38.0))
		XCTAssertEqual(sublayouts[1].frame, CGRect(x: 36.0, y: 5.0, width: 26.0, height: 38.0))
		XCTAssertEqual(sublayouts[2].frame, CGRect(x: 66.0, y: 5.0, width: 26.0, height: 38.0))
	}
	
	func testDistributeInRect() {
		let layouts = [StubLayout(), StubLayout(), StubLayout(), StubLayout()] as [LayoutType]
		let rect    = CGRect(x: 10.0, y: 20.0, width: 30.0, height: 80.0)
		
		layouts.distributeIn(rect, axis: .Vertical, spacing: 2.0, margin: LayoutInsets(top: 1.0, left: 2.0, bottom: 3.0, right: 4.0))
		
		XCTAssertEqual(layouts[0].frame, CGRect(x: 12.0, y: 21.0, width: 24.0, height: 17.5))
		XCTAssertEqual(layouts[1].frame, CGRect(x: 12.0, y: 40.5, width: 24.0, height: 17.5))
		XCTAssertEqual(layouts[2].frame, CGRect(x: 12.0, y: 60.0, width: 24.0, height: 17.5))
		XCTAssertEqual(layouts[3].frame, CGRect(x: 12.0, y: 79.5, width: 24.0, height: 17.5))
	}
}

extension LayoutTypeTest {
	private func stubSuperlayout(superframe superframe: CGRect = CGRect(), subframe: CGRect = CGRect()) -> (superlayout: StubLayout, sublayout: StubLayout) {
		let superlayout        = StubLayout(frame: superframe, superlayout: nil)
		let sublayout          = StubLayout(frame: subframe,   superlayout: superlayout)
		superlayout.sublayouts = [sublayout]
		return (superlayout, sublayout)
	}
	
	private func stubSublayouts(sublayoutCount sublayoutCount: Int, superframe: CGRect = CGRect(), subframe: CGRect = CGRect()) -> StubLayout {
		let superlayout        = StubLayout(frame: superframe, superlayout: nil)
		superlayout.sublayouts = (0 ..< sublayoutCount).map { _ in StubLayout(frame: subframe, superlayout: superlayout) }
		return superlayout
	}
}

class StubLayout: LayoutType {
	var frame = CGRect()
	var superlayout: LayoutType?
	var sublayouts = [LayoutType]()
	var naturalSize: CGSize
	
	init(frame: CGRect = CGRect(), superlayout: LayoutType? = nil, sublayouts: [LayoutType] = [], naturalSize: CGSize = CGSize()) {
		self.frame       = frame
		self.superlayout = superlayout
		self.sublayouts  = sublayouts
		self.naturalSize = naturalSize
	}
	
	func naturalSizeConstrainedBy(width width: CGFloat?, height: CGFloat?) -> CGSize {
		return CGSize(width: width ?? naturalSize.width, height: height ?? naturalSize.height)
	}
}
