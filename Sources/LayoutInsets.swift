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
	
	// MARK: Getting information about the insets
	
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
}
