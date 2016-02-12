import XCTest
@testable import LayoutKit

class LayoutTypeTest: XCTestCase {
	func testBounds() {
		let layout = StubLayout(frame: CGRect(x: 10.0, y: 20.0, width: 100.0, height: 150.0))
		XCTAssertEqual(layout.bounds,  CGRect(x:  0.0, y:  0.0, width: 100.0, height: 150.0))
	}
	
	func testCenterInSuperlayout() {
		let (_, sublayout) = stubSuperlayout(superframe: CGRect(x: 20.0, y: 40.0, width: 120.0, height: 80.0))
		
		sublayout.centerInSuperlayout(
			width:  .Amount(50.0),
			height: .Ratio(0.5),
			insets: LayoutInsets(horizontal: 4.0, vertical: 8.0)
		)
		
		XCTAssertEqual(sublayout.frame, CGRect(x: 35.0, y: 22.0, width: 50.0, height: 36.0))
		
		sublayout.naturalSize = CGSize(width: 10.0, height: 20.0)
		sublayout.centerInSuperlayout()
		XCTAssertEqual(sublayout.frame, CGRect(x: 55.0, y: 30.0, width: 10.0, height: 20.0))
	}
	
	func testCenterInRect() {
		let layout = StubLayout()
		let rect   = CGRect(x: 10.0, y: 50.0, width: 90.0, height: 60.0)
		
		layout.centerIn(rect,
			width:  .Ratio(0.2),
			height: .Amount(20.0),
			insets: LayoutInsets(horizontal: 20.0, vertical: 40.0)
		)
		
		XCTAssertEqual(layout.frame, CGRect(x: 48.0, y: 70.0, width: 14.0, height: 20.0))
		
		layout.naturalSize = CGSize(width: 100.0, height: 200.0)
		layout.centerIn(rect)
		XCTAssertEqual(layout.frame, CGRect(x: 5.0, y: -20.0, width: 100.0, height: 200.0))
	}
	
	func testFillSuperlayout() {
		let (_, sublayout) = stubSuperlayout(superframe: CGRect(x: 10.0, y: 60.0, width: 90.0, height: 30.0))
		sublayout.fillSuperlayout(insets: LayoutInsets(horizontal: 30.0, vertical: 10.0))
		XCTAssertEqual(sublayout.frame, CGRect(x: 15.0, y: 5.0, width: 60.0, height: 20.0))
	}
	
	func testFillRect() {
		let layout = StubLayout()
		let rect   = CGRect(x: -30.0, y: -50.0, width: 20.0, height: 40.0)
		layout.fill(rect, insets: LayoutInsets(horizontal: 8.0, vertical: 12.0))
		XCTAssertEqual(layout.frame, CGRect(x: -26.0, y: -44.0, width: 12.0, height: 28.0))
	}
	
	func testAnchorInSuperlayout() {
		let (_, sublayout) = stubSuperlayout(superframe: CGRect(x: 5.0, y: 10.0, width: 80.0, height: 40.0))
		
		sublayout.anchorInSuperlayout(
			x:      .Ratio(0.25),
			y:      .Amount(20.0),
			width:  .Ratio(0.5),
			height: .Amount(10.0),
			insets: LayoutInsets(horizontal: 20.0, vertical: 10.0)
		)
		
		XCTAssertEqual(sublayout.frame, CGRect(x: 17.5, y: 25.0, width: 30.0, height: 10.0))
		
		sublayout.naturalSize = CGSize(width: 50.0, height: 70.0)
		sublayout.anchorInSuperlayout(x: .Amount(10.0), y: .Ratio(1.0))
		XCTAssertEqual(sublayout.frame, CGRect(x: 10.0, y: -30.0, width: 50.0, height: 70.0))
	}
	
	func testAnchorInRect() {
		let layout = StubLayout()
		let rect   = CGRect(x: 40.0, y: 60.0, width: 100.0, height: 40.0)
		
		layout.anchorIn(rect,
			x:      .Ratio(1.0),
			y:      .Ratio(0.75),
			width:  .Ratio(0.25),
			height: .Amount(20.0),
			insets: LayoutInsets(horizontal: 30.0, vertical: 10.0)
		)
		
		XCTAssertEqual(layout.frame, CGRect(x: 107.5, y: 72.5, width: 17.5, height: 20.0))
		
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
		
		superlayout.sublayouts.distributeInSuperlayout(axis: .Horizontal, spacing: 4.0, insets: LayoutInsets(top: 5.0, left: 6.0, bottom: 7.0, right: 8.0))
		
		XCTAssertEqual(sublayouts[0].frame, CGRect(x:  6.0, y: 5.0, width: 26.0, height: 38.0))
		XCTAssertEqual(sublayouts[1].frame, CGRect(x: 36.0, y: 5.0, width: 26.0, height: 38.0))
		XCTAssertEqual(sublayouts[2].frame, CGRect(x: 66.0, y: 5.0, width: 26.0, height: 38.0))
	}
	
	func testDistributeInRect() {
		let layouts = [StubLayout(), StubLayout(), StubLayout(), StubLayout()] as [LayoutType]
		let rect    = CGRect(x: 10.0, y: 20.0, width: 30.0, height: 80.0)
		
		layouts.distributeIn(rect, axis: .Vertical, spacing: 2.0, insets: LayoutInsets(top: 1.0, left: 2.0, bottom: 3.0, right: 4.0))
		
		XCTAssertEqual(layouts[0].frame, CGRect(x: 12.0, y: 21.0, width: 24.0, height: 17.5))
		XCTAssertEqual(layouts[1].frame, CGRect(x: 12.0, y: 40.5, width: 24.0, height: 17.5))
		XCTAssertEqual(layouts[2].frame, CGRect(x: 12.0, y: 60.0, width: 24.0, height: 17.5))
		XCTAssertEqual(layouts[3].frame, CGRect(x: 12.0, y: 79.5, width: 24.0, height: 17.5))
	}
	
	func testDistributeInSuperlayoutWithConstraints() {
		let superlayout = stubSublayouts(sublayoutCount: 3, superframe: CGRect(x: 10.0, y: 20.0, width: 100.0, height: 400.0))
		let sublayouts  = superlayout.sublayouts
		let spacing     = CGFloat(5.0)
		let insets      = LayoutInsets(top: 8.0, left: 7.0, bottom: 6.0, right: 5.0)
		
		[
			(sublayouts[0], .Weight(0.25)),
			(sublayouts[1], .Amount(15.0)),
			(sublayouts[2], .Weight(1.0))
		].distributeInSuperlayout(axis: .Vertical, spacing: spacing, insets: insets)
		
		XCTAssertEqual(sublayouts[0].frame, CGRect(x: 7.0, y: 8.0,   width: 88.0, height: 72.2))
		XCTAssertEqual(sublayouts[1].frame, CGRect(x: 7.0, y: 85.2,  width: 88.0, height: 15.0))
		XCTAssertEqual(sublayouts[2].frame, CGRect(x: 7.0, y: 105.2, width: 88.0, height: 288.8))
		
		[
			(sublayouts[0], .CappedWeight(weight: 0.25, min: 10.0, max: 30.0)),
			(sublayouts[1], .Amount(15.0)),
			(sublayouts[2], .Weight(1.0))
		].distributeInSuperlayout(axis: .Vertical, spacing: spacing, insets: insets)
		
		XCTAssertEqual(sublayouts[0].frame, CGRect(x: 7.0, y: 8.0,  width: 88.0, height: 30.0))
		XCTAssertEqual(sublayouts[1].frame, CGRect(x: 7.0, y: 43.0, width: 88.0, height: 15.0))
		XCTAssertEqual(sublayouts[2].frame, CGRect(x: 7.0, y: 63.0, width: 88.0, height: 331.0))
	}
	
	func testDistributeInRectWithConstraints() {
		let rect    = CGRect(x: 10.0, y: 20.0, width: 600.0, height: 200.0)
		let layouts = [StubLayout(), StubLayout(), StubLayout(), StubLayout()]
		let spacing = CGFloat(8.0)
		let insets  = LayoutInsets(top: 2.0, left: 3.0, bottom: 4.0, right: 5.0)
		
		[
			(layouts[0], .Weight(0.3)),
			(layouts[1], .Amount(20.0)),
			(layouts[2], .Weight(0.5)),
			(layouts[3], .CappedWeight(weight: 0.2, min: 10.0, max: 30.0))
		].distributeIn(rect, axis: .Horizontal, spacing: spacing, insets: insets)
		
		XCTAssertEqual(layouts[0].frame, CGRect(x: 13.0,   y: 22.0, width: 194.25, height: 194.0))
		XCTAssertEqual(layouts[1].frame, CGRect(x: 215.25, y: 22.0, width: 20.0,   height: 194.0))
		XCTAssertEqual(layouts[2].frame, CGRect(x: 243.25, y: 22.0, width: 323.75, height: 194.0))
		XCTAssertEqual(layouts[3].frame, CGRect(x: 575.0,  y: 22.0, width: 30.0,   height: 194.0))
		
		[
			(layouts[0], .Amount(10.0)),
			(layouts[1], .CappedWeight(weight: 0.4, min: 400.0, max: 600.0)),
			(nil,        .Amount(6.0)),
			(layouts[2], .Weight(0.4)),
			(layouts[3], .Weight(0.2))
		].distributeIn(rect, axis: .Horizontal, spacing: spacing, insets: insets)
		
		XCTAssertEqual(layouts[0].frame, CGRect(x: 13.0, y: 22.0, width: 10.0,  height: 194.0))
		XCTAssertEqual(layouts[1].frame, CGRect(x: 31.0, y: 22.0, width: 400.0, height: 194.0))
		
		// These particular rects experience rounding issues.
		XCTAssertEqual(floorRect(layouts[2].frame), floorRect(CGRect(x: 453.0, y: 22.0, width: 96.0, height: 194.0)))
		XCTAssertEqual(floorRect(layouts[3].frame), floorRect(CGRect(x: 557.0, y: 22.0, width: 48.0, height: 194.0)))
	}
	
	private func floorRect(rect: CGRect) -> CGRect {
		return CGRect(x: floor(rect.x), y: floor(rect.y), width: floor(rect.size.width), height: floor(rect.size.height))
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
