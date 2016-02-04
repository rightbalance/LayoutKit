import CoreGraphics

extension CGRect {
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
}
