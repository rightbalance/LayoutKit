import AppKit
import LayoutKit

class AnchorDemoViewController: ModernViewController {
	// MARK: Initializing
	
	init() {
		super.init(nibName: nil, bundle: nil)!
		
		title = "Anchors"
		
		view.addSubview(topLeftView)
		view.addSubview(topView)
		view.addSubview(topRightView)
		view.addSubview(rightView)
		view.addSubview(bottomRightView)
		view.addSubview(bottomView)
		view.addSubview(bottomLeftView)
		view.addSubview(leftView)
		view.addSubview(centerView)
	}
	
	required init(coder: NSCoder) {
		fatalError("NSCoding not supported.")
	}
	
	// MARK: Views
	
	let topLeftView     = DemoView(text: "Top Left")
	let topView         = DemoView(text: "Top")
	let topRightView    = DemoView(text: "Top Right")
	let rightView       = DemoView(text: "Right")
	let bottomRightView = DemoView(text: "Bottom Right")
	let bottomView      = DemoView(text: "Bottom")
	let bottomLeftView  = DemoView(text: "Bottom Left")
	let leftView        = DemoView(text: "Left")
	let centerView      = DemoView(text: "Center")
	
	// MARK: Layout
	
	override func viewDidLayout() {
		super.viewDidLayout()
		
		let insets = LayoutInsets(uniformValue: 20.0)
		
		topLeftView     .anchorInSuperlayout(x: .Ratio(0.0), y: .Ratio(0.0), width: .Amount(30.0), height: .Amount(30.0), insets: insets)
		topRightView    .anchorInSuperlayout(x: .Ratio(1.0), y: .Ratio(0.0), width: .Amount(30.0), height: .Amount(30.0), insets: insets)
		bottomRightView .anchorInSuperlayout(x: .Ratio(1.0), y: .Ratio(1.0), width: .Amount(30.0), height: .Amount(30.0), insets: insets)
		bottomLeftView  .anchorInSuperlayout(x: .Ratio(0.0), y: .Ratio(1.0), width: .Amount(30.0), height: .Amount(30.0), insets: insets)
		
		topView    .anchorInSuperlayout(x: .Ratio(0.5), y: .Ratio(0.0), width: .Ratio(0.5),   height: .Amount(30.0), insets: insets)
		bottomView .anchorInSuperlayout(x: .Ratio(0.5), y: .Ratio(1.0), width: .Ratio(0.5),   height: .Amount(30.0), insets: insets)
		leftView   .anchorInSuperlayout(x: .Ratio(0.0), y: .Ratio(0.5), width: .Amount(30.0), height: .Ratio(0.5),   insets: insets)
		rightView  .anchorInSuperlayout(x: .Ratio(1.0), y: .Ratio(0.5), width: .Amount(30.0), height: .Ratio(0.5),   insets: insets)
		
		centerView.centerInSuperlayout(width: .Ratio(0.25), height: .Ratio(0.25), insets: insets)
	}
}
