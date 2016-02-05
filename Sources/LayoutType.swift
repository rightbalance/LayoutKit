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
