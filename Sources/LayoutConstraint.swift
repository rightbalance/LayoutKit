import CoreGraphics

public enum LayoutConstraint {
	case Amount(CGFloat)
	case Weight(CGFloat)
	case CappedWeight(weight: CGFloat, min: CGFloat?, max: CGFloat?)
}
