public enum LayoutAxis {
	case Horizontal, Vertical
	
	public var perpendicularAxis: LayoutAxis {
		switch self {
			case .Horizontal: return .Vertical
			case .Vertical:   return .Horizontal
		}
	}
}
