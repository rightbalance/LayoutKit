import CoreGraphics

/// A positioned, infinite grid of uniform 2D cells that can be used to achieve a grid-based layout.
public struct LayoutGrid: Equatable {
	// MARK: Initializing
	
	/// Initializes with basic values.
	public init(origin: CGPoint = CGPoint(), cellSize: CGSize = CGSize(), cellSpacing: CGPoint = CGPoint()) {
		self.origin      = origin
		self.cellSize    = cellSize
		self.cellSpacing = cellSpacing
	}
	
	/// Initializes by calculating a cell size based on a number of columns and rows within a rect.
	///
	/// - REQUIRES: `columnCount` and `rowCount` >= 0
	///
	public init(rect: CGRect, columnCount: Int, rowCount: Int, cellSpacing: CGPoint = CGPoint(), insets: LayoutInsets = LayoutInsets()) {
		precondition(columnCount >= 0, "Tried to create a layout grid with a negative column count.")
		precondition(rowCount    >= 0, "Tried to create a layout grid with a negative row count.")
		
		let gridSize = rect.size - insets.size
		
		let totalCellSpacing = CGSize(
			width:  cellSpacing.x * CGFloat(max(columnCount - 1, 0)),
			height: cellSpacing.y * CGFloat(max(rowCount    - 1, 0))
		)
		
		let cellSize = CGSize(
			width:  (gridSize.width  - totalCellSpacing.width)  / CGFloat(columnCount),
			height: (gridSize.height - totalCellSpacing.height) / CGFloat(rowCount)
		)
		
		self.init(origin: CGPoint(x: rect.x + insets.left, y: rect.y + insets.top), cellSize: cellSize, cellSpacing: cellSpacing)
	}
	
	// MARK: Accessing values
	
	/// The position of the layout grid.
	public var origin: CGPoint
	
	/// The size of each cell in the grid.
	public var cellSize: CGSize
	
	/// The spacing between each cell in the grid.
	public var cellSpacing: CGPoint
	
	// MARK: Getting cell bounds
	
	/// Returns the bounds for the cell at the given location.
	///
	/// Rows and columns are allowed to be negative.
	///
	public func boundsForCellAt(column column: Int, row: Int) -> CGRect {
		return boundsForAreaIn(columnRange: column ... column, rowRange: row ... row)
	}
	
	/// Returns the bounds for the area that spans the given range of columns and rows.
	///
	/// Row and column ranges are allowed to be negative.
	///
	public func boundsForAreaIn(columnRange columnRange: Range<Int>, rowRange: Range<Int>) -> CGRect {
		let columnCount = columnRange.count
		let rowCount    = columnRange.count
		
		return CGRect(
			x:      origin.x + (cellSize.width  + cellSpacing.x) * CGFloat(columnRange.startIndex),
			y:      origin.y + (cellSize.height + cellSpacing.y) * CGFloat(rowRange.startIndex),
			width:  cellSize.width  * CGFloat(columnCount) + cellSpacing.x * CGFloat(columnCount - 1),
			height: cellSize.height * CGFloat(rowCount)    + cellSpacing.y * CGFloat(rowCount    - 1)
		)
	}
}

public func ==(a: LayoutGrid, b: LayoutGrid) -> Bool {
	return a.origin == b.origin && a.cellSize == b.cellSize && a.cellSpacing == b.cellSpacing
}
