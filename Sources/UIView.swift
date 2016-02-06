import UIKit

extension UIView: LayoutType {
	public var superlayout: LayoutType? {
		return superview
	}
	
	public var sublayouts: [LayoutType] {
		return subviews
	}
	
	public var naturalSize: CGSize {
		return naturalSizeConstrainedBy(width: nil, height: nil)
	}
	
	public func naturalSizeConstrainedBy(width width: CGFloat?, height: CGFloat?) -> CGSize {
		if width == nil || height == nil {
			let intrinsicContentSize = self.intrinsicContentSize()
			
			return CGSize(
				width:  width  ?? intrinsicContentSize.width,
				height: height ?? intrinsicContentSize.height
			)
		} else {
			return intrinsicContentSize()
		}
	}
}
