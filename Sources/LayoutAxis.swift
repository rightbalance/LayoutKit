public enum LayoutAxis {
	case Horizontal, Vertical
	
	/// The axis perpendicular to the receiver.
	public var perpendicularAxis: LayoutAxis {
		switch self {
			case .Horizontal: return .Vertical
			case .Vertical:   return .Horizontal
		}
	}
	
	/// The edge that is approached as a position becomes smaller while traveling along the receiver.
	public var minEdge: LayoutEdge {
		switch self {
			case .Horizontal: return .Left
			case .Vertical:   return .Top
		}
	}
	
	/// The edge that is approached as a position becomes larger while traveling along the receiver.
	public var maxEdge: LayoutEdge {
		switch self {
			case .Horizontal: return .Right
			case .Vertical:   return .Bottom
		}
	}
}
