import AppKit

class DemoView: ModernView {
	init(color: NSColor) {
		super.init()
		layer!.backgroundColor = color.CGColor
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
}
