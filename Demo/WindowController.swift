import AppKit

class WindowController: NSWindowController {
	@IBAction func segmentedControlWasClicked(segmentedControl: NSSegmentedControl) {
		print("yo!", segmentedControl)
	}
}
