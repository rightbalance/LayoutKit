import AppKit

class WindowController: NSWindowController {
	@IBOutlet var segmentedControl:            NSSegmentedControl!
	@IBOutlet var segmentedControlToolbarItem: NSToolbarItem!
	
	var demoGalleryViewController: DemoGalleryViewController {
		return contentViewController as! DemoGalleryViewController
	}
	
	override func windowDidLoad() {
		super.windowDidLoad()
		
		segmentedControl.segmentCount = demoGalleryViewController.viewControllers.count
		
		for (index, viewController) in demoGalleryViewController.viewControllers.enumerate() {
			segmentedControl.setLabel(viewController.title ?? "", forSegment: index)
		}
		
		segmentedControl.sizeToFit()
		segmentedControlToolbarItem.minSize = segmentedControl.frame.size
		segmentedControlToolbarItem.maxSize = segmentedControlToolbarItem.minSize
	}
	
	@IBAction func segmentedControlWasClicked(segmentedControl: NSSegmentedControl) {
		demoGalleryViewController.selectViewControllerAt(segmentedControl.selectedSegment)
	}
}
