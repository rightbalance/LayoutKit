import Foundation

#if os(iOS)
	public typealias LayoutInsets = UIEdgeInsets
#else
	public typealias LayoutInsets = NSEdgeInsets
#endif

extension LayoutInsets {
	// MARK: Initializing
	
	/// Initializes with the given horizontal value, which will be distributed equally to the left and right.
	public init(horizontal: CGFloat) {
		self.init()
		self.horizontal = horizontal
	}
	
	/// Initializes with the given vertical value, which will be distributed equally to the top and bottom.
	public init(vertical: CGFloat) {
		self.init()
		self.vertical = vertical
	}
	
	/// Initializes with the given horizontal and vertical values, which will be distributed equally along their
	/// respective axes.
	public init(horizontal: CGFloat, vertical: CGFloat) {
		self.init()
		self.horizontal = horizontal
		self.vertical   = vertical
	}
	
	// MARK: Managing inset values
	
	/// The sum of the left and right insets. Setting distributes the value equally to the left and right.
	public var horizontal: CGFloat {
		get { return left + right }
		set {
			left  = newValue / 2.0
			right = left
		}
	}
	
	/// The sum of the top and bottom insets. Setting distributes the value equally to the top and bottom.
	public var vertical: CGFloat {
		get { return top + bottom }
		set {
			top    = newValue / 2.0
			bottom = top
		}
	}
	
	/// Provides access to the insets on each axis. Setting distributes the value equally to both ends of the axis.
	public subscript(axis: LayoutAxis) -> CGFloat {
		get {
			switch axis {
				case .Horizontal: return horizontal
				case .Vertical:   return vertical
			}
		}
		set {
			switch axis {
				case .Horizontal: horizontal = newValue
				case .Vertical:   vertical   = newValue
			}
		}
	}
	
	/// Provides access to the insets by edge.
	public subscript(edge: LayoutEdge) -> CGFloat {
		get {
			switch edge {
				case .Top:    return top
				case .Bottom: return bottom
				case .Left:   return left
				case .Right:  return right
			}
		}
		set {
			switch edge {
				case .Top:    top    = newValue
				case .Bottom: bottom = newValue
				case .Left:   left   = newValue
				case .Right:  right  = newValue
			}
		}
	}
}
