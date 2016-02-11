public enum LayoutConstraint {
	case Amount(Double)
	case Weight(Double)
	case Range(min: Double, max: Double)
	case CappedWeight(weight: Double, min: Double?, max: Double?)
}
