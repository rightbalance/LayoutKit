import AppKit
import LayoutKit

class DemoViewController: NSViewController {
	// MARK: View lifecycle
	
	override func loadView() {
		view = ModernView()
		selectViewAt(0)
	}
	
	override func viewWillAppear() {
		super.viewWillAppear()
		view.window?.titleVisibility = .Hidden
	}
	
	// MARK: Selecting views
	
	private let views: [NSView] = [
		AnchorDemoView()
	]
	
	private var selectedView: NSView?
	
	func selectViewAt(index: Int) {
		let newSelectedView = views[index]
		selectedView?.removeFromSuperview()
		selectedView = newSelectedView
		view.addSubview(newSelectedView)
	}
	
	// MARK: Layout
	
	override func viewDidLayout() {
		super.viewDidLayout()
		selectedView?.fillSuperlayout()
	}
}

private class ModernView: NSView {
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

private class AnchorDemoView: ModernView {
	let topLeftView     = DemoView(color: NSColor.greenColor())
	let topView         = DemoView(color: NSColor.redColor())
	let topRightView    = DemoView(color: NSColor.blueColor())
	let rightView       = DemoView(color: NSColor.yellowColor())
	let bottomRightView = DemoView(color: NSColor.orangeColor())
	let bottomView      = DemoView(color: NSColor.purpleColor())
	let bottomLeftView  = DemoView(color: NSColor.whiteColor())
	let leftView        = DemoView(color: NSColor.brownColor())
	let centerView      = DemoView(color: NSColor.blackColor())
	
	override init() {
		super.init()
		addSubview(topLeftView)
		addSubview(topView)
		addSubview(topRightView)
		addSubview(rightView)
		addSubview(bottomRightView)
		addSubview(bottomView)
		addSubview(bottomLeftView)
		addSubview(leftView)
		addSubview(centerView)
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
	
	override func layout() {
		super.layout()
		
		topLeftView     .anchorInSuperlayout(x: .Ratio(0.0), y: .Ratio(0.0), width: .Amount(30.0), height: .Amount(30.0))
		topRightView    .anchorInSuperlayout(x: .Ratio(1.0), y: .Ratio(0.0), width: .Amount(30.0), height: .Amount(30.0))
		bottomRightView .anchorInSuperlayout(x: .Ratio(1.0), y: .Ratio(1.0), width: .Amount(30.0), height: .Amount(30.0))
		bottomLeftView  .anchorInSuperlayout(x: .Ratio(0.0), y: .Ratio(1.0), width: .Amount(30.0), height: .Amount(30.0))
		
		topView    .anchorInSuperlayout(x: .Ratio(0.5), y: .Ratio(0.0), width: .Ratio(0.5),   height: .Amount(30.0))
		bottomView .anchorInSuperlayout(x: .Ratio(0.5), y: .Ratio(1.0), width: .Ratio(0.5),   height: .Amount(30.0))
		leftView   .anchorInSuperlayout(x: .Ratio(0.0), y: .Ratio(0.5), width: .Amount(30.0), height: .Ratio(0.5))
		rightView  .anchorInSuperlayout(x: .Ratio(1.0), y: .Ratio(0.5), width: .Amount(30.0), height: .Ratio(0.5))
		
		centerView.centerInSuperlayout(width: .Amount(30.0), height: .Amount(30.0))
	}
}

private class DemoView: ModernView {
	init(color: NSColor) {
		super.init()
		layer!.backgroundColor = color.CGColor
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
}
