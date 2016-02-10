import AppKit
import LayoutKit

class GridDemoView: ModernView {
	let topView   = DemoView(color: NSColor.greenColor())
	let leftView  = DemoView(color: NSColor.blueColor())
	var cellViews = [DemoView]()
	
	let columnCount = 6
	let rowCount    = 5
	
	var cellCount: Int {
		return (columnCount - 1) * (rowCount - 1)
	}
	
	override init() {
		super.init()
		
		addSubview(topView)
		addSubview(leftView)
		
		for _ in 0 ..< cellCount {
			let cellView = DemoView(color: NSColor.redColor())
			cellViews.append(cellView)
			addSubview(cellView)
		}
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
	
	override func layout() {
		super.layout()
		
		let grid       = LayoutGrid(rect: bounds, columnCount: columnCount, rowCount: rowCount, cellSpacing: CGPoint(x: 8.0, y: 8.0), insets: LayoutInsets(uniformValue: 16.0))
		topView.frame  = grid.boundsForAreaIn(columnRange: 1 ... 5, rowRange: 0 ... 0)
		leftView.frame = grid.boundsForAreaIn(columnRange: 0 ... 0, rowRange: 0 ... 4)
		
		for i in 0 ..< cellCount {
			cellViews[i].frame = grid.boundsForCellAt(column: i % (columnCount - 1) + 1, row: i / (columnCount - 1) + 1)
		}
	}
}
