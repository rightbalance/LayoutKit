import AppKit
import LayoutKit

class DemoGalleryViewController: ModernViewController {
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.layer!.backgroundColor = NSColor(calibratedRed: 0.115, green: 0.12, blue: 0.13, alpha: 1.0).CGColor
		selectViewControllerAt(0)
	}
	
	override func viewWillAppear() {
		super.viewWillAppear()
		view.window?.titleVisibility = .Hidden
	}
	
	// MARK: Managing view controllers
	
	let viewControllers = [
		AnchorDemoViewController(),
		GridDemoViewController(),
		SidebarDemoViewController()
	]
	
	private var selectedViewControllerIndex: Int?
	
	private var selectedViewController: NSViewController? {
		guard let index = selectedViewControllerIndex else {
			return nil
		}
		
		return viewControllers[index]
	}
	
	func selectViewControllerAt(index: Int) {
		selectedViewController?.view.removeFromSuperview()
		selectedViewController?.removeFromParentViewController()
		
		let viewController          = viewControllers[index]
		selectedViewControllerIndex = index
		addChildViewController(viewController)
		view.addSubview(viewController.view)
	}
	
	// MARK: Layout
	
	override func viewDidLayout() {
		super.viewDidLayout()
		selectedViewController?.view.fillSuperlayout()
	}
}
