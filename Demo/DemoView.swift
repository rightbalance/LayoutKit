import AppKit
import LayoutKit

class DemoView: ModernView {
	// MARK: Initializing
	
	init(color: NSColor = NSColor(calibratedRed: 0.7, green: 0.75, blue: 0.8, alpha: 1.0), text: String = "") {
		super.init()
		layer!.backgroundColor = NSColor(calibratedRed: 0.25, green: 0.3, blue: 0.325, alpha: 1.0).CGColor
		layer!.borderColor     = color.CGColor
		layer!.borderWidth     = 2.0
		label.stringValue      = text
		label.editable         = false
		label.selectable       = false
		label.backgroundColor  = nil
		label.bordered         = false
		label.font             = NSFont.systemFontOfSize(14.0, weight: NSFontWeightRegular)
		label.textColor        = NSColor(calibratedWhite: 0.9, alpha: 1.0)
		addSubview(label)
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
	
	// MARK: Views
	
	let label = NSTextField()
	
	// MARK: Layout
	
	override func layout() {
		super.layout()
		label.centerInSuperlayout()
	}
}
