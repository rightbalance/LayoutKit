public enum LayoutEdge {
	case Top, Bottom, Left, Right
	
	public var parallelAxis: LayoutAxis {
		switch self {
			case .Top, .Bottom: return .Horizontal
			case .Left, .Right: return .Vertical
		}
	}
	
	public var perpendicularAxis: LayoutAxis {
		return parallelAxis.perpendicularAxis
	}
}
