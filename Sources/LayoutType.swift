import CoreGraphics

public protocol LayoutType: class {
	var frame:       CGRect      { get set }
	var bounds:      CGRect      { get }
	var superlayout: LayoutType? { get }
	var sublayouts: [LayoutType] { get }
}

extension LayoutType {
	public var bounds: CGRect {
		return frame.positionedAt(x: 0.0, y: 0.0)
	}
	
	// MARK: Anchoring
	
	public func centerInSuperlayout() {
		guard let superlayout = superlayout else {
			fatalError("Tried to center a layout in its superlayout, but it doesn't have a superlayout.")
		}
		
		centerIn(superlayout.bounds)
	}
	
	public func centerIn(layout: LayoutType) {
		centerIn(layout.frame)
	}
	
	public func centerIn(rect: CGRect) {
		frame = frame.size.centeredIn(rect)
	}
	
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
