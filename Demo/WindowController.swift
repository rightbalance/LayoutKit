import AppKit

class WindowController: NSWindowController {
	var demoViewController: DemoViewController {
		return  contentViewController as! DemoViewController
	}
	
	@IBAction func segmentedControlWasClicked(segmentedControl: NSSegmentedControl) {
		demoViewController.selectViewAt(segmentedControl.selectedSegment)
	}
}
