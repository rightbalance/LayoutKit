import AppKit

class AnchorDemoView: ModernView {
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
