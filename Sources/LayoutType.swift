import CoreGraphics

public protocol LayoutType: class {
	var frame:       CGRect      { get set }
	var bounds:      CGRect      { get }
	var superlayout: LayoutType? { get }
	var sublayouts: [LayoutType] { get }
}

extension LayoutType {
	// MARK: Getting layout information
	
	public var bounds: CGRect {
		return frame.positionedAt(x: 0.0, y: 0.0)
	}
	
	// MARK: Centering
	
	public func centerInSuperlayout(width width: LayoutValue? = nil, height: LayoutValue? = nil) {
		guard let superlayout = superlayout else {
			fatalError("Tried to center a layout in its superlayout, but it doesn't have a superlayout.")
		}
		
		centerIn(superlayout.bounds, width: width, height: height)
	}
	
	public func centerIn(rect: CGRect, width: LayoutValue? = nil, height: LayoutValue? = nil) {
		frame = CGSize(
			width:  width?.valueRelativeTo(rect.width)   ?? frame.width,
			height: height?.valueRelativeTo(rect.height) ?? frame.height
		).centeredIn(rect)
	}
	
	// MARK: Anchoring in
	
	public func anchorInSuperlayout(x x: LayoutValue, y: LayoutValue, width: LayoutValue? = nil, height: LayoutValue? = nil) {
		guard let superlayout = superlayout else {
			fatalError("Tried to anchor a layout in its superlayout, but it doesn't have a superlayout.")
		}
		
		anchorIn(superlayout.bounds, x: x, y: y, width: width, height: height)
	}
	
	public func anchorIn(rect: CGRect, x: LayoutValue, y: LayoutValue, width: LayoutValue? = nil, height: LayoutValue? = nil) {
		frame = CGSize(
			width:  width?.valueRelativeTo(rect.width)   ?? frame.width,
			height: height?.valueRelativeTo(rect.height) ?? frame.height
		).anchoredIn(rect, x: x, y: y)
	}
	
	// MARK: Anchoring to
	
	public func anchorToSuperlayout(edge edge: LayoutEdge, parallelAnchor: LayoutValue, perpendicularAnchor: LayoutValue = .Ratio(0.0), width: LayoutValue? = nil, height: LayoutValue? = nil) {
		guard let superlayout = superlayout else {
			fatalError("Tried to anchor a layout to its superlayout, but it doesn't have a superlayout.")
		}
		
		anchorTo(superlayout.bounds, edge: edge, parallelAnchor: parallelAnchor, perpendicularAnchor: perpendicularAnchor, width: width, height: height)
	}
	
	public func anchorTo(rect: CGRect, edge: LayoutEdge, parallelAnchor: LayoutValue, perpendicularAnchor: LayoutValue = .Ratio(0.0), width: LayoutValue? = nil, height: LayoutValue? = nil) {
		frame = CGSize(
			width:  width?.valueRelativeTo(rect.width)   ?? frame.width,
			height: height?.valueRelativeTo(rect.height) ?? frame.height
		).anchoredTo(rect, edge: edge, parallelAnchor: parallelAnchor, perpendicularAnchor: perpendicularAnchor)
	}
}

extension CollectionType where Index == Int, Generator.Element == LayoutType {
	public func distributeInSuperlayout(axis axis: LayoutAxis, spacing: CGFloat = 0.0, margin: LayoutInsets = LayoutInsets()) {
		guard let first = first else {
			fatalError("Tried to distribute an empty list of layouts in their superlayout.")
		}
		
		guard let superlayout = first.superlayout else {
			fatalError("Tried to distribute a list of layouts in their superlayout, but a superlayout was not found.")
		}
		
		for layout in self {
			assert(layout.superlayout === superlayout, "Tried to distribute a list of layouts in their superlayout, but their superlayouts did not match.")
		}
		
		distributeIn(superlayout.bounds, axis: axis, spacing: spacing, margin: margin)
	}
	
	public func distributeIn(rect: CGRect, axis primaryAxis: LayoutAxis, spacing: CGFloat = 0.0, margin: LayoutInsets = LayoutInsets()) {
		let count = self.count
		
		assert(count > 0, "Tried to distribute an empty list of layouts.")
		
		let secondaryAxis = primaryAxis.perpendicularAxis
		let totalSpacing  = spacing * CGFloat(count - 1)
		
		var frame                    = CGRect(origin: rect.origin)
		frame.origin[primaryAxis]   += margin[primaryAxis.minEdge]
		frame.origin[secondaryAxis] += margin[secondaryAxis.minEdge]
		frame.size[primaryAxis]      = (rect.size[primaryAxis] - margin[primaryAxis] - totalSpacing) / CGFloat(count)
		frame.size[secondaryAxis]    = rect.size[secondaryAxis] - margin[secondaryAxis]
		
		for index in startIndex ..< endIndex {
			self[index].frame          = frame
			frame.origin[primaryAxis] += frame.size[primaryAxis] + spacing
		}
	}
}
