import AppKit
import LayoutKit

class GridDemoViewController: ModernViewController {
	// MARK: Initializing
	
	init() {
		super.init(nibName: nil, bundle: nil)!
		
		title = "Grids"
		
		view.addSubview(topView)
		view.addSubview(leftView)
		
		for _ in 0 ..< cellCount {
			let cellView = DemoView(text: "Cell")
			cellViews.append(cellView)
			view.addSubview(cellView)
		}
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
	
	// MARK: Configuration
	
	let columnCount = 6
	let rowCount    = 5
	
	var cellCount: Int {
		return (columnCount - 1) * (rowCount - 1)
	}
	
	// MARK: Views
	
	let topView   = DemoView(text: "Top")
	let leftView  = DemoView(text: "Left")
	var cellViews = [DemoView]()
	
	override func viewDidLayout() {
		super.viewDidLayout()
		
		let grid       = LayoutGrid(rect: view.bounds, columnCount: columnCount, rowCount: rowCount, cellSpacing: CGPoint(x: 8.0, y: 8.0), insets: LayoutInsets(uniformValue: 16.0))
		topView.frame  = grid.boundsForAreaIn(columnRange: 1 ... 5, rowRange: 0 ... 0)
		leftView.frame = grid.boundsForAreaIn(columnRange: 0 ... 0, rowRange: 0 ... 4)
		
		for i in 0 ..< cellCount {
			cellViews[i].frame = grid.boundsForCellAt(column: i % (columnCount - 1) + 1, row: i / (columnCount - 1) + 1)
		}
	}
}
