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
		AnchorDemoView(),
		GridDemoView()
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
