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

	override var representedObject: Any? {
		didSet {

		}
	}
	
	static func newInstance() -> ViewController {
		let storyboard: NSStoryboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
		let indentifier: NSStoryboard.SceneIdentifier = NSStoryboard.SceneIdentifier("ViewController")
		
		guard let viewController = storyboard.instantiateController(withIdentifier: indentifier) as? ViewController else {
			fatalError("Unable to instantiate ViewController in Main.storyboard")
		}
		
		return viewController
	}
	

}

