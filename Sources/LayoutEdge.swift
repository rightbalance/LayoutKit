public enum LayoutEdge {
	case Top, Bottom, Left, Right
	
	/// The axis parallel to the receiver.
	public var parallelAxis: LayoutAxis {
		switch self {
			case .Top, .Bottom: return .Horizontal
			case .Left, .Right: return .Vertical
		}
	}
	
	/// The axis perpendicular to the receiver.
	public var perpendicularAxis: LayoutAxis {
		return parallelAxis.perpendicularAxis
	}
}
