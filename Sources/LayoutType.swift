import CoreGraphics

public protocol LayoutType: class {
	/// The layout's framed area expressed in the coordinate system of its superlayout.
	var frame: CGRect { get set }
	
	/// The layout's bounded area expressed in its own coordinate system.
	///
	/// `LayoutType` provides a default implementation of this property by returning `frame` with an origin of zero.
	///
	var bounds: CGRect { get }
	
	/// The layout's superlayout.
	var superlayout: LayoutType? { get }
	
	/// The layout's nested sublayouts.
	var sublayouts: [LayoutType] { get }
	
	/// Returns the unconstrained natural size of the layout based only on its own properties.
	///
	/// `LayoutType` provides a default implementation of this property by calling
	/// `naturalSizeConstrainedBy(width:height:)` with a nil width and height. It is recommended that conforming types
	/// implement only that method.
	///
	var naturalSize: CGSize { get }
	
	/// Returns the layout's natural size based only on its own properties, constrained by the given width and height,
	/// if any.
	///
	/// A layout's natural size is whatever size that would be most appropriate for the layout to take on by default.
	/// Generally, this is the minimum size of the layout that comfortably fits all of its content. For example, the
	/// expected natural size for a label would be the smallest size that can contain all of its text.
	///
	/// If a non-nil width or height is given, then it is expected that the returned size will use that width or
	/// height. How this works can
	///
	func naturalSizeConstrainedBy(width width: CGFloat?, height: CGFloat?) -> CGSize
}

extension LayoutType {
	// MARK: Getting layout information
	
	/// The default implementation of the layout's bounds, which is its frame positioned at (0, 0).
	public var bounds: CGRect {
		return frame.positionedAt(x: 0.0, y: 0.0)
	}
	
	/// The default implementation of the layout's natural size, which calls `naturalSizeConstrainedBy(width:height:)`
	/// with a nil width and height.
	public var naturalSize: CGSize {
		return naturalSizeConstrainedBy(width: nil, height: nil)
	}
	
	// MARK: Centering
	
	/// Centers the layout within its superlayout.
	///
	/// If a width or height is not provided, the layout's natural width or height will be used.
	///
	/// - REQUIRES: The layout's `superlayout` property is not nil.
	///
	public func centerInSuperlayout(width width: LayoutValue? = nil, height: LayoutValue? = nil, insets: LayoutInsets = LayoutInsets()) {
		guard let superlayout = superlayout else {
			fatalError("Tried to center a layout in its superlayout, but it doesn't have a superlayout.")
		}
		
		centerIn(superlayout.bounds, width: width, height: height, insets: insets)
	}
	
	/// Centers the layout within the given rect.
	///
	/// If a width or height is not provided, the layout's natural width or height will be used.
	///
	public func centerIn(rect: CGRect, width: LayoutValue? = nil, height: LayoutValue? = nil, insets: LayoutInsets = LayoutInsets()) {
		frame = sizeRelativeTo(rect.size - insets.size, width: width, height: height).centeredIn(rect)
	}
	
	// MARK: Filling
	
	/// Sets the frame of the layout such that it fills its superview.
	public func fillSuperlayout(insets insets: LayoutInsets = LayoutInsets()) {
		guard let superlayout = superlayout else {
			fatalError("Tried to make a layout fill its superlayout, but it doesn't have a superlayout.")
		}
		
		fill(superlayout.bounds, insets: insets)
	}
	
	/// Sets the frame of the layout such that it fills the given rect.
	public func fill(rect: CGRect, insets: LayoutInsets = LayoutInsets()) {
		frame = rect.insetBy(insets)
	}
	
	// MARK: Anchoring in
	
	/// Anchors the layout within its superlayout.
	///
	/// If a width or height is not provided, the layout's natural width or height will be used.
	///
	/// - REQUIRES: The layout's `superlayout` property is not nil.
	///
	public func anchorInSuperlayout(x x: LayoutValue, y: LayoutValue, width: LayoutValue? = nil, height: LayoutValue? = nil, insets: LayoutInsets = LayoutInsets()) {
		guard let superlayout = superlayout else {
			fatalError("Tried to anchor a layout in its superlayout, but it doesn't have a superlayout.")
		}
		
		anchorIn(superlayout.bounds, x: x, y: y, width: width, height: height, insets: insets)
	}
	
	/// Anchors the layout within the given rect.
	///
	/// If a width or height is not provided, the layout's natural width or height will be used.
	///
	public func anchorIn(rect: CGRect, x: LayoutValue, y: LayoutValue, width: LayoutValue? = nil, height: LayoutValue? = nil, insets: LayoutInsets = LayoutInsets()) {
		let insetRect = rect.insetBy(insets)
		frame         = sizeRelativeTo(insetRect.size, width: width, height: height).anchoredIn(insetRect, x: x, y: y)
	}
	
	// MARK: Anchoring to
	
	/// Anchors the layout to an outer edge of its superlayout.
	///
	/// If a width or height is not provided, the layout's natural width or height will be used.
	///
	/// - REQUIRES: The layout's `superlayout` property is not nil.
	///
	public func anchorToSuperlayout(edge edge: LayoutEdge, parallelAnchor: LayoutValue, perpendicularAnchor: LayoutValue = .Ratio(0.0), width: LayoutValue? = nil, height: LayoutValue? = nil) {
		guard let superlayout = superlayout else {
			fatalError("Tried to anchor a layout to its superlayout, but it doesn't have a superlayout.")
		}
		
		anchorTo(superlayout.bounds, edge: edge, parallelAnchor: parallelAnchor, perpendicularAnchor: perpendicularAnchor, width: width, height: height)
	}
	
	/// Anchors the layout to an outer edge of the given rect.
	///
	/// If a width or height is not provided, the layout's natural width or height will be used.
	///
	public func anchorTo(rect: CGRect, edge: LayoutEdge, parallelAnchor: LayoutValue, perpendicularAnchor: LayoutValue = .Ratio(0.0), width: LayoutValue? = nil, height: LayoutValue? = nil) {
		frame = sizeRelativeTo(rect.size, width: width, height: height).anchoredTo(rect, edge: edge, parallelAnchor: parallelAnchor, perpendicularAnchor: perpendicularAnchor)
	}
	
	// MARK: Getting sizes
	
	/// Returns the size of the layout relative to another size based on the given width and height layout values.
	///
	/// Uses the layout's natural width or height when the given width or height is nil.
	///
	private func sizeRelativeTo(relativeSize: CGSize, width: LayoutValue?, height: LayoutValue?) -> CGSize {
		if let width = width, height = height {
			return CGSize(
				width:  width.valueRelativeTo(relativeSize.width),
				height: height.valueRelativeTo(relativeSize.height)
			)
		} else {
			let naturalSize = self.naturalSize
			
			return CGSize(
				width:  width?.valueRelativeTo(relativeSize.width)   ?? naturalSize.width,
				height: height?.valueRelativeTo(relativeSize.height) ?? naturalSize.height
			)
		}
	}
}

extension CollectionType where Index == Int, Generator.Element == LayoutType {
	/// Distributes the layouts equally along an axis within their common superlayout.
	///
	/// - REQUIRES: All layouts have the same non-nil superlayout.
	///
	public func distributeInSuperlayout(axis axis: LayoutAxis, spacing: CGFloat = 0.0, insets: LayoutInsets = LayoutInsets()) {
		guard let first = first else { return }
		
		guard let superlayout = first.superlayout else {
			fatalError("Tried to distribute a list of layouts in their superlayout, but a superlayout was not found.")
		}
		
		for layout in self {
			assert(layout.superlayout === superlayout, "Tried to distribute a list of layouts in their superlayout, but their superlayouts did not match.")
		}
		
		distributeIn(superlayout.bounds, axis: axis, spacing: spacing, insets: insets)
	}
	
	/// Distributes the layouts equally along an axis within the given rect.
	public func distributeIn(rect: CGRect, axis primaryAxis: LayoutAxis, spacing: CGFloat = 0.0, insets: LayoutInsets = LayoutInsets()) {
		let count = self.count
		
		guard count > 0 else { return }
		
		let secondaryAxis = primaryAxis.perpendicularAxis
		let totalSpacing  = spacing * CGFloat(count - 1)
		
		var frame                    = CGRect(origin: rect.origin)
		frame.origin[primaryAxis]   += insets[primaryAxis.minEdge]
		frame.origin[secondaryAxis] += insets[secondaryAxis.minEdge]
		frame.size[primaryAxis]      = (rect.size[primaryAxis] - insets[primaryAxis] - totalSpacing) / CGFloat(count)
		frame.size[secondaryAxis]    = rect.size[secondaryAxis] - insets[secondaryAxis]
		
		for index in startIndex ..< endIndex {
			self[index].frame          = frame
			frame.origin[primaryAxis] += frame.size[primaryAxis] + spacing
		}
	}
}

extension CollectionType where Index == Int, Generator.Element == (LayoutType?, LayoutConstraint) {
	/// Distributes the layouts with the given constraints along an axis within their common superlayout.
	///
	/// - REQUIRES: All layouts have the same non-nil superlayout, and at least one layout is non-nil.
	///
	public func distributeInSuperlayout(axis axis: LayoutAxis, spacing: CGFloat = 0.0, insets: LayoutInsets = LayoutInsets()) {
		var superlayout: LayoutType?
		
		for (layout, _) in self where layout != nil {
			guard let thisSuperlayout = layout?.superlayout else {
				fatalError("Tried to distribute a list of constrained layouts in their superlayout, but a superlayout was not found.")
			}
			
			if superlayout == nil {
				superlayout = thisSuperlayout
			}
			
			precondition(thisSuperlayout === superlayout, "Tried to distribute a list of layouts in their superlayout, but their superlayouts did not match.")
		}
		
		if let superlayout = superlayout {
			distributeIn(superlayout.bounds, axis: axis, spacing: spacing, insets: insets)
		} else {
			fatalError("At least one non-nil layout is required when distributing layouts.")
		}
	}
	
	/// Distributes the layouts with the given constraints along an axis within the given rect.
	public func distributeIn(rect: CGRect, axis primaryAxis: LayoutAxis, spacing: CGFloat = 0.0, insets: LayoutInsets = LayoutInsets()) {
		fatalError("Not implemented yet.")
	}
}
