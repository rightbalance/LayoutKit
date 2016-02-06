public enum LayoutAxis {
	case Horizontal, Vertical
	
	public var perpendicularAxis: LayoutAxis {
		switch self {
			case .Horizontal: return .Vertical
			case .Vertical:   return .Horizontal
		}
	}
	
	public var minEdge: LayoutEdge {
		switch self {
			case .Horizontal: return .Left
			case .Vertical:   return .Top
		}
	}
	
	public var maxEdge: LayoutEdge {
		switch self {
			case .Horizontal: return .Right
			case .Vertical:   return .Bottom
		}
	}
}
