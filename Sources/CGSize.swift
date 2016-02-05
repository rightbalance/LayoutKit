import CoreGraphics

extension CGSize {
	// MARK: Initializing
	
	public init(equalDimension: CGFloat) {
		self.init(width: equalDimension, height: equalDimension)
	}
	
	// MARK: Anchoring
	
	public func centeredIn(rect: CGRect) -> CGRect {
		return anchoredIn(rect, x: .Ratio(0.5), y: .Ratio(0.5))
	}
	
	public func anchoredIn(rect: CGRect, x: LayoutValue, y: LayoutValue) -> CGRect {
		var anchoredRect  = rect
		anchoredRect.size = self
		anchoredRect.x   += x.positionRelativeTo(outerLength: rect.width,  innerLength: width)
		anchoredRect.y   += y.positionRelativeTo(outerLength: rect.height, innerLength: height)
		return anchoredRect
	}
	
	public func anchoredTo(rect: CGRect, edge: LayoutEdge, parallelAnchor: LayoutValue, perpendicularAnchor: LayoutValue = .Ratio(0.0)) -> CGRect {
		var anchoredRect  = rect
		anchoredRect.size = self
		
		let parallelAxis = edge.parallelAxis
		
		anchoredRect.setPosition(
			anchoredRect.positionOn(parallelAxis) + parallelAnchor.positionRelativeTo(
				outerLength: rect.lengthOn(parallelAxis),
				innerLength: lengthOn(parallelAxis)
			),
			onAxis: parallelAxis
		)
		
		switch edge {
			case .Top:    anchoredRect.y = rect.minY - height - perpendicularAnchor.valueRelativeTo(height)
			case .Bottom: anchoredRect.y = rect.maxY          + perpendicularAnchor.valueRelativeTo(height)
			case .Left:   anchoredRect.x = rect.minX - width  - perpendicularAnchor.valueRelativeTo(width)
			case .Right:  anchoredRect.x = rect.maxX          + perpendicularAnchor.valueRelativeTo(width)
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
	
	public func lengthOn(axis: LayoutAxis) -> CGFloat {
		switch axis {
			case .Horizontal: return width
			case .Vertical:   return height
		}
	}
	
	public mutating func setLength(length: CGFloat, onAxis axis: LayoutAxis) {
		switch axis {
			case .Horizontal: width  = length
			case .Vertical:   height = length
		}
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
