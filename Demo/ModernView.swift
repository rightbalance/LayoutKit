import AppKit

class ModernView: NSView {
	init() {
		super.init(frame: CGRect())
		wantsLayer = true
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
	
	override var flipped: Bool {
		return true
	}
}
