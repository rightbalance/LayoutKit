import CoreGraphics

public enum LayoutValue {
	case Amount(CGFloat)
	case Ratio(CGFloat)
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
			case .Ratio       (let ratio):             return (outerLength - innerLength) * ratio // (100 - 20) * -0.5 = -40. x is 40. 40 - 100 = -60. so -60 to 40. -10 is middle. 20 is width. so value should actually be -20 right?
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
