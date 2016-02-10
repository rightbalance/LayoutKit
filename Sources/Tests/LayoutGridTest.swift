import XCTest
@testable import LayoutKit

class LayoutGridTest: XCTestCase {
	func testInitWithRect() {
		XCTAssertEqual(
			LayoutGrid(
				rect:        CGRect(x: 50.0, y: 60.0, width: 200.0, height: 100.0),
				columnCount: 4,
				rowCount:    5,
				cellSpacing: CGPoint(x: 2.0, y: 3.0),
				insets:      LayoutInsets(top: 6.0, left: 9.0, bottom: 8.0, right: 7.0)
			),
			
			LayoutGrid(
				origin:      CGPoint(x: 59.0, y: 66.0),
				cellSize:    CGSize(width: 44.5, height: 14.8),
				cellSpacing: CGPoint(x: 2.0, y: 3.0)
			)
		)
	}
	
	func testCellBounds() {
		let grid = LayoutGrid(
			origin:      CGPoint(x: -50.0, y: -60.0),
			cellSize:    CGSize(width: 30.0, height: 50.0),
			cellSpacing: CGPoint(x: 10.0, y: 30.0)
		)
		
		XCTAssertEqual(grid.boundsForCellAt(column:  0, row:  0), CGRect(x: -50.0, y:  -60.0, width: 30.0, height: 50.0))
		XCTAssertEqual(grid.boundsForCellAt(column:  1, row:  0), CGRect(x: -10.0, y:  -60.0, width: 30.0, height: 50.0))
		XCTAssertEqual(grid.boundsForCellAt(column:  1, row:  1), CGRect(x: -10.0, y:   20.0, width: 30.0, height: 50.0))
		XCTAssertEqual(grid.boundsForCellAt(column:  5, row:  5), CGRect(x: 150.0, y:  340.0, width: 30.0, height: 50.0))
		XCTAssertEqual(grid.boundsForCellAt(column: -1, row: -1), CGRect(x: -90.0, y: -140.0, width: 30.0, height: 50.0))
		
		XCTAssertEqual(
			grid.boundsForAreaIn(columnRange: 0 ... 1, rowRange: 0 ... 1),
			CGRect(x: -50.0, y: -60.0, width: 70.0, height: 130.0)
		)
		
		XCTAssertEqual(
			grid.boundsForAreaIn(columnRange: -2 ... 2, rowRange: -2 ... 4),
			CGRect(x: -130.0, y: -220.0, width: 190.0, height: 530.0)
		)
		
		XCTAssertEqual(
			grid.boundsForAreaIn(columnRange: 3 ... 5, rowRange: 6 ... 7),
			CGRect(x: 70.0, y: 420.0, width: 110.0, height: 130.0)
		)
	}
}
