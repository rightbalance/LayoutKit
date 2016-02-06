import CoreGraphics

extension CGSize {
	// MARK: Initializing
	
	/// Initializes a size with equal values for width and height.
	public init(equalLength: CGFloat) {
		self.init(width: equalLength, height: equalLength)
	}
	
	// MARK: Anchoring
	
	/// Returns a rect with the size of the receiver, centered in the given rect.
	public func centeredIn(rect: CGRect) -> CGRect {
		return anchoredIn(rect, x: .Ratio(0.5), y: .Ratio(0.5))
	}
	
	/// Returns a rect with the size of the receiver anchored at the given position inside the rect.
	public func anchoredIn(rect: CGRect, x: LayoutValue, y: LayoutValue) -> CGRect {
		var anchoredRect  = rect
		anchoredRect.size = self
		anchoredRect.x   += x.positionRelativeTo(outerLength: rect.width,  innerLength: width)
		anchoredRect.y   += y.positionRelativeTo(outerLength: rect.height, innerLength: height)
		return anchoredRect
	}
	
	/// Returns a rect with the size of the receiver anchored to an outer edge of the given rect.
	public func anchoredTo(rect: CGRect, edge: LayoutEdge, parallelAnchor: LayoutValue, perpendicularAnchor: LayoutValue = .Ratio(0.0)) -> CGRect {
		var anchoredRect  = rect
		anchoredRect.size = self
		
		let parallelAxis = edge.parallelAxis
		
		anchoredRect.origin[parallelAxis] += parallelAnchor.positionRelativeTo(
			outerLength: rect.size[parallelAxis],
			innerLength: self[parallelAxis]
		)
		
		switch edge {
			case .Top:    anchoredRect.y = rect.minY - height - perpendicularAnchor.valueRelativeTo(height)
			case .Bottom: anchoredRect.y = rect.maxY          + perpendicularAnchor.valueRelativeTo(height)
			case .Left:   anchoredRect.x = rect.minX - width  - perpendicularAnchor.valueRelativeTo(width)
			case .Right:  anchoredRect.x = rect.maxX          + perpendicularAnchor.valueRelativeTo(width)
		}
		
		return anchoredRect
	}
	
	// MARK: Accessing size properties
	
	/// The smaller of the size's width and height.
	public var minLength: CGFloat {
		return min(width, height)
	}
	
	/// The larger of the size's width and height.
	public var maxLength: CGFloat {
		return max(width, height)
	}
	
	/// Provides subscripting access to the sizes values on the given axis.
	public subscript(axis: LayoutAxis) -> CGFloat {
		get {
			switch axis {
				case .Horizontal: return width
				case .Vertical:   return height
			}
		}
		set {
			switch axis {
				case .Horizontal: width  = newValue
				case .Vertical:   height = newValue
			}
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
