import AppKit
import LayoutKit

class GridDemoView: ModernView {
	let topView    = DemoView(color: NSColor.yellowColor())
	let bottomView = DemoView(color: NSColor.orangeColor())
	let leftView   = DemoView(color: NSColor.blueColor())
	let rightView  = DemoView(color: NSColor.greenColor())
	let centerView = DemoView(color: NSColor.whiteColor())
	
	override init() {
		super.init()
		addSubview(topView)
		addSubview(bottomView)
		addSubview(leftView)
		addSubview(rightView)
		addSubview(centerView)
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
	
	override func layout() {
		super.layout()
		
		let grid         = LayoutGrid(rect: bounds, columnCount: 6, rowCount: 5, cellSpacing: CGPoint(x: 8.0, y: 8.0), insets: LayoutInsets(uniformValue: 16.0))
		topView.frame    = grid.boundsForAreaIn(columnRange: 2 ... 3, rowRange: 0 ... 0)
		bottomView.frame = grid.boundsForAreaIn(columnRange: 2 ... 3, rowRange: 4 ... 4)
		leftView.frame   = grid.boundsForAreaIn(columnRange: 0 ... 0, rowRange: 0 ... 4)
		rightView.frame  = grid.boundsForAreaIn(columnRange: 5 ... 5, rowRange: 0 ... 4)
	}
}
