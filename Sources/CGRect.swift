import CoreGraphics

extension CGRect {
	// MARK: Initializing
	
	public init(origin: CGPoint, width: CGFloat = 0.0, height: CGFloat = 0.0) {
		self.init(origin: origin, size: CGSize(width: width, height: height))
	}
	
	public init(x: CGFloat = 0.0, y: CGFloat = 0.0, size: CGSize) {
		self.init(origin: CGPoint(x: x, y: y), size: size)
	}
	
	// MARK: Accessing properties
	
	/// The rect's x value.
	public var x: CGFloat {
		get { return origin.x     }
		set { origin.x = newValue }
	}
	
	/// The rect's y value.
	public var y: CGFloat {
		get { return origin.y     }
		set { origin.y = newValue }
	}
	
	/// The rect's width value.
	public var width: CGFloat {
		get { return size.width     }
		set { size.width = newValue }
	}
	
	/// The rect's height value.
	public var height: CGFloat {
		get { return size.height     }
		set { size.height = newValue }
	}
	
	/// The rect's center point.
	public var center: CGPoint {
		get { return CGPoint(x: midX, y: midY)                                        }
		set { origin = CGPoint(x: center.x - width / 2.0, y: center.y - height / 2.0) }
	}
	
	// MARK: Positioning
	
	public func positionedAt(x x: CGFloat, y: CGFloat) -> CGRect {
		return positionedAt(CGPoint(x: x, y: y))
	}
	
	public func positionedAt(point: CGPoint) -> CGRect {
		return CGRect(x: point.x, y: point.y, width: width, height: height)
	}
	
	// MARK: Getting information about the rect
	
	public func positionAt(edge: LayoutEdge, inset: CGFloat = 0.0) -> CGFloat {
		switch edge {
			case .Top:    return minY + inset
			case .Bottom: return maxY - inset
			case .Left:   return minX + inset
			case .Right:  return maxX - inset
		}
	}
}
