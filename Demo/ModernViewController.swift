import AppKit

class ModernViewController: NSViewController {
	override func loadView() {
		view = ModernView()
	}
}

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
