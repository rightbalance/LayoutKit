import AppKit
import LayoutKit

class SidebarDemoViewController: ModernViewController {
	// MARK: Initializing
	
	init() {
		super.init(nibName: nil, bundle: nil)!
		
		title = "Sidebar"
		
		view.addSubview(sidebarView)
		view.addSubview(dividerView)
		view.addSubview(contentView)
		contentView.addSubview(contentAccessoryView)
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
	
	// MARK: Views
	
	let sidebarView          = DemoView(text: "Sidebar")
	let dividerView          = DemoView(color: NSColor(calibratedWhite: 0.1, alpha: 1.0))
	let contentView          = DemoView(text: "Content")
	let contentAccessoryView = DemoView(text: "Content Accessory")
	
	override func viewDidLayout() {
		super.viewDidLayout()
		
		[
			(sidebarView, .CappedWeight(weight: 0.25, min: 180.0, max: 300.0)),
			(dividerView, .Amount(1.0)),
			(contentView, .Weight(0.75))
		].distributeInSuperlayout(axis: .Horizontal)
		
		contentAccessoryView.anchorInSuperlayout(x: .Amount(0.0), y: .Ratio(1.0), width: .Ratio(1.0), height: .Amount(200.0))
	}
}
