//
//  ViewController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/21.
//

import Cocoa

class ViewController: NSViewController {
	
	override func viewDidLoad() {
	    super.viewDidLoad()
	}
	
	static func newInstance() -> ViewController {
		let storyboard: NSStoryboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
		let identifier: NSStoryboard.SceneIdentifier = NSStoryboard.SceneIdentifier("ViewController")
		
		guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
			fatalError("Unable to instantiate ViewController in Main.storyboard")
		}
		return viewController
	}
	
	func initMeetingManagerUI() {
		
		for view in view.subviews {
			view.removeFromSuperview()
		}
	}
	
	@objc
	func test(sender: NSButton) {
		initMeetingManagerUI()
	}
	
}
