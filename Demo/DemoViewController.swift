import AppKit
import LayoutKit

class DemoViewController: NSViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear() {
		super.viewWillAppear()
		view.window?.titleVisibility = .Hidden
	}
	
	// MARK: Switching views
	
	@IBOutlet var viewSegmentedControl: NSSegmentedControl?
}
