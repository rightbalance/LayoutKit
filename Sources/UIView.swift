import UIKit

extension UIView: LayoutType {
	public var superlayout: LayoutType? {
		return superview
	}
	
	public var sublayouts: [LayoutType] {
		return subviews
	}
}
