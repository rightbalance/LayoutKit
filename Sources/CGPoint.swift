import CoreGraphics

extension CGPoint {
	// MARK: Getting information about the point
	
	/// Provides subscripting access to the point's values on the given axis.
	public subscript(axis: LayoutAxis) -> CGFloat {
		get {
			switch axis {
				case .Horizontal: return x
				case .Vertical:   return y
			}
		}
		set {
			switch axis {
				case .Horizontal: x = newValue
				case .Vertical:   y = newValue
			}
		}
	}
}
