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
	
	public func centerInSuperlayout(size size: CGSize? = nil) {
		guard let superlayout = superlayout else {
			fatalError("Tried to center a layout in its superlayout, but it doesn't have a superlayout.")
		}
		
		centerIn(superlayout.bounds, size: size)
	}
	
	public func centerIn(layout: LayoutType, size: CGSize? = nil) {
		centerIn(layout.frame, size: size)
	}
	
	public func centerIn(rect: CGRect, size: CGSize? = nil) {
		frame = (size ?? frame.size).centeredIn(rect)
	}
	
	// MARK: Anchoring in
	
	public func anchorInSuperlayout(xAnchor xAnchor: CGFloat, yAnchor: CGFloat) {
		guard let superlayout = superlayout else {
			fatalError("Tried to anchor a layout in its superlayout, but it doesn't have a superlayout.")
		}
		
		anchorIn(superlayout.bounds, xAnchor: xAnchor, yAnchor: yAnchor)
	}
	
	public func anchorIn(layout: LayoutType, xAnchor: CGFloat, yAnchor: CGFloat) {
		anchorIn(layout.frame, xAnchor: xAnchor, yAnchor: yAnchor)
	}
	
	public func anchorIn(rect: CGRect, xAnchor: CGFloat, yAnchor: CGFloat) {
		frame = frame.size.anchoredIn(rect, xAnchor: xAnchor, yAnchor: yAnchor)
	}
	
	// MARK: Anchoring to
	
	public func anchorToSuperlayout(edge edge: Edge, parallelAnchor: CGFloat, perpendicularAnchor: CGFloat = 1.0) {
		guard let superlayout = superlayout else {
			fatalError("Tried to anchor a layout to its superlayout, but it doesn't have a superlayout.")
		}
		
		anchorTo(superlayout.bounds, edge: edge, parallelAnchor: parallelAnchor, perpendicularAnchor: perpendicularAnchor)
	}
	
	public func anchorTo(layout: LayoutType, edge: Edge, parallelAnchor: CGFloat, perpendicularAnchor: CGFloat = 1.0) {
		anchorTo(layout.frame, edge: edge, parallelAnchor: parallelAnchor, perpendicularAnchor: perpendicularAnchor)
	}
	
	public func anchorTo(rect: CGRect, edge: Edge, parallelAnchor: CGFloat, perpendicularAnchor: CGFloat = 1.0) {
		frame = frame.size.anchoredTo(rect, edge: edge, parallelAnchor: parallelAnchor, perpendicularAnchor: perpendicularAnchor)
	}
}
