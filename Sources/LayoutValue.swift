import CoreGraphics

/// A value used to calculate the position or size of a layout.
public enum LayoutValue {
	/// A constant value. When used for a position or size, this exact value will be used.
	case Amount(CGFloat)
	
	/// A relative value. What the value is relative to depends on the context. For example, a layout could use a ratio
	/// value of 0.5 relative to its superlayout's size to dynamically size itself to half of its superlayout's size.
	case Ratio(CGFloat)
	
	/// An offset relative value. Works the same as a regular ratio, but offset by a constant amount.
	case OffsetRatio(offset: CGFloat, ratio: CGFloat)
	
	public func valueRelativeTo(relativeValue: CGFloat) -> CGFloat {
		switch self {
			case .Amount      (let amount):            return amount
			case .Ratio       (let ratio):             return ratio * relativeValue
			case .OffsetRatio (let offset, let ratio): return ratio * relativeValue + offset
		}
	}
	
	public func positionRelativeTo(outerLength outerLength: CGFloat, innerLength: CGFloat) -> CGFloat {
		switch self {
			case .Amount      (let amount):            return amount
			case .Ratio       (let ratio):             return (outerLength - innerLength) * ratio
			case .OffsetRatio (let offset, let ratio): return (outerLength - innerLength) * ratio + offset
		}
	}
}

public func +(a: LayoutValue, b: LayoutValue) -> LayoutValue {
	switch a {
		case .Amount(let amountA): switch b {
			case .Amount      (let offsetB):             return .Amount(amountA + offsetB)
			case .Ratio       (let ratioB):              return .OffsetRatio(offset: amountA, ratio: ratioB)
			case .OffsetRatio (let offsetB, let ratioB): return .OffsetRatio(offset: amountA + offsetB, ratio: ratioB)
		}
		
		case .Ratio(let ratioA): switch b {
			case .Amount      (let offsetB):             return .OffsetRatio(offset: offsetB, ratio: ratioA)
			case .Ratio       (let ratioB):              return .Ratio(ratioA + ratioB)
			case .OffsetRatio (let offsetB, let ratioB): return .OffsetRatio(offset: offsetB, ratio: ratioA + ratioB)
		}
		
		case .OffsetRatio(let offsetA, let ratioA): switch b {
			case .Amount      (let offsetB):             return .OffsetRatio(offset: offsetA + offsetB, ratio: ratioA)
			case .Ratio       (let ratioB):              return .OffsetRatio(offset: offsetA,           ratio: ratioA + ratioB)
			case .OffsetRatio (let offsetB, let ratioB): return .OffsetRatio(offset: offsetA + offsetB, ratio: ratioA + ratioB)
		}
	}
}

public func -(a: LayoutValue, b: LayoutValue) -> LayoutValue {
	switch a {
		case .Amount(let amountA): switch b {
			case .Amount      (let amountB):             return .Amount(amountA - amountB)
			case .Ratio       (let ratioB):              return .OffsetRatio(offset: amountA,           ratio: -ratioB)
			case .OffsetRatio (let offsetB, let ratioB): return .OffsetRatio(offset: amountA - offsetB, ratio: -ratioB)
		}
		
		case .Ratio(let ratioA): switch b {
			case .Amount      (let amountB):             return .OffsetRatio(offset: -amountB, ratio: ratioA)
			case .Ratio       (let ratioB):              return .Ratio(ratioA - ratioB)
			case .OffsetRatio (let offsetB, let ratioB): return .OffsetRatio(offset: -offsetB, ratio: ratioA - ratioB)
		}
		
		case .OffsetRatio(let offsetA, let ratioA): switch b {
			case .Amount      (let amountB):             return .OffsetRatio(offset: offsetA - amountB, ratio: ratioA)
			case .Ratio       (let ratioB):              return .OffsetRatio(offset: offsetA,           ratio: ratioA - ratioB)
			case .OffsetRatio (let offsetB, let ratioB): return .OffsetRatio(offset: offsetA - offsetB, ratio: ratioA - ratioB)
		}
	}
}
