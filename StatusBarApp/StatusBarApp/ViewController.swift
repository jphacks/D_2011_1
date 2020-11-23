//
//  ViewController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/21.
//

import Cocoa

class ViewController: NSViewController {
	
	let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
	let popover: NSPopover = NSPopover()
	override func viewDidLoad() {
	    super.viewDidLoad()
		if let button: NSStatusBarButton = statusItem.button {
			button.image = NSImage(named: NSImage.Name("timer"))
			button.action = #selector(AppDelegate.togglePopover(_:))
		}
		popover.contentViewController = ViewController.newInstance()
		popover.animates = false
	}
	
	static func newInstance() -> ViewController {
		let storyboard: NSStoryboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
		let identifier: NSStoryboard.SceneIdentifier = NSStoryboard.SceneIdentifier("ViewController")
		
		guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
			fatalError("Unable to instantiate ViewController in Main.storyboard")
		}
		return viewController
	}
}
