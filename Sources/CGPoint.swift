import CoreGraphics

extension CGPoint {
	// MARK: Getting information about the point
	
	public func positionOn(axis: LayoutAxis) -> CGFloat {
		switch axis {
			case .Horizontal: return x
			case .Vertical:   return y
		}
	}
}
