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
	
	public var x: CGFloat {
		get { return origin.x     }
		set { origin.x = newValue }
	}
	
	public var y: CGFloat {
		get { return origin.y     }
		set { origin.y = newValue }
	}
	
	public var width: CGFloat {
		get { return size.width     }
		set { size.width = newValue }
	}
	
	public var height: CGFloat {
		get { return size.height     }
		set { size.height = newValue }
	}
	
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
	
	public func positionOn(axis: LayoutAxis) -> CGFloat {
		return origin.positionOn(axis)
	}
	
	public mutating func setPosition(position: CGFloat, onAxis axis: LayoutAxis) {
		origin.setPosition(position, onAxis: axis)
	}
	
	public func lengthOn(axis: LayoutAxis) -> CGFloat {
		return size.lengthOn(axis)
	}
	
	public mutating func setLength(length: CGFloat, onAxis axis: LayoutAxis) {
		size.setLength(length, onAxis: axis)
	}
	
	public func positionAt(edge: LayoutEdge, inset: CGFloat = 0.0) -> CGFloat {
		switch edge {
			case .Top:    return minY + inset
			case .Bottom: return maxY - inset
			case .Left:   return minX + inset
			case .Right:  return maxX - inset
		}
	}
}
