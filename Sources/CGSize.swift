import CoreGraphics

extension CGSize {
	// MARK: Initializing
	
	public init(equalDimension: CGFloat) {
		self.init(width: equalDimension, height: equalDimension)
	}
	
	// MARK: Anchoring
	
	public func centeredIn(rect: CGRect) -> CGRect {
		return anchoredIn(rect, xAnchor: 0.5, yAnchor: 0.5)
	}
	
	public func anchoredIn(rect: CGRect, xAnchor: CGFloat, yAnchor: CGFloat) -> CGRect {
		var anchoredRect       = rect
		anchoredRect.size      = self
		anchoredRect.origin.x += (rect.width  - width)  * xAnchor
		anchoredRect.origin.y += (rect.height - height) * yAnchor
		return anchoredRect
	}
	
	public func anchoredTo(rect: CGRect, edge: Edge, parallelAnchor: CGFloat, perpendicularAnchor: CGFloat = 1.0) -> CGRect {
		var anchoredRect  = rect
		anchoredRect.size = self
		
		switch edge {
			case .Top:
				anchoredRect.origin.x += (rect.width - width) * parallelAnchor
				anchoredRect.origin.y  = rect.minY - height * perpendicularAnchor
			case .Bottom:
				anchoredRect.origin.x += (rect.width - width) * parallelAnchor
				anchoredRect.origin.y  = rect.maxY + height * (perpendicularAnchor - 1.0)
			case .Left:
				anchoredRect.origin.x  = rect.minX - width * perpendicularAnchor
				anchoredRect.origin.y += (rect.height - height) * parallelAnchor
			case .Right:
				anchoredRect.origin.x  = rect.maxX + width * (perpendicularAnchor - 1.0)
				anchoredRect.origin.y += (rect.height - height) * parallelAnchor
		}
		
		return anchoredRect
	}
	
	// MARK: Getting information about the size
	
	public var minDimension: CGFloat {
		return min(width, height)
	}
	
	public var maxDimension: CGFloat {
		return max(width, height)
	}
}

public func +(a: CGSize, b: CGSize) -> CGSize {
	var c     = a
	c.width  += b.width
	c.height += b.height
	return c
}

public func -(a: CGSize, b: CGSize) -> CGSize {
	var c     = a
	c.width  -= b.width
	c.height -= b.height
	return c
}
