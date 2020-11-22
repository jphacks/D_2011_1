//
//  NSWindowController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/22.
//

import Cocoa

class MainWindowController: NSWindowController {
	
	let idTextField: NSTextField = NSTextField()
	let popoverLabel: NSTextField = NSTextField()
	var submitButton: NSButton = NSButton()
	override func windowDidLoad() {
		super.windowDidLoad()
		initDefaultUI()
	}

	private func windowDidMiniaturize(notification: NSNotification) {
		print("Window minimized")
	}

	private func windowWillClose(notification: NSNotification) {
		print("Window closing")
	}
	
	func initDefaultUI() {
		popoverLabel.frame.size = CGSize(width: window!.frame.width, height: 30)
		// もっといい書き方ありそう(frame.size.centerがなかった)
		let popoverLabel: NSTextField = NSTextField()
		popoverLabel.stringValue = "ミーティングIDを入力してください"
		popoverLabel.font = NSFont.labelFont(ofSize: 16)
		popoverLabel.sizeToFit()
		// もっと良いやり方がありそう
		popoverLabel.frame.origin = CGPoint(x: window!.frame.width / 2 - popoverLabel.frame.size.width / 2, y: 150)
		popoverLabel.alignment = .center
		popoverLabel.isEditable = false
		popoverLabel.isBordered = false
		popoverLabel.drawsBackground = false
		window?.contentView?.addSubview(popoverLabel)
		
		idTextField.frame.size = CGSize(width: window!.frame.width / 2, height: 20)
		idTextField.frame.origin = CGPoint(x: window!.frame.width / 2 - idTextField.frame.size.width / 2, y: 100)
		window?.contentView?.addSubview(idTextField)
		
		let submitButton: NSButton = NSButton()
		submitButton.title = "入室する"
		submitButton.font = NSFont.labelFont(ofSize: 16)
		submitButton.bezelStyle = .rounded
		submitButton.sizeToFit()
		submitButton.identifier = NSUserInterfaceItemIdentifier(rawValue: "submitButton")
		submitButton.frame.origin = CGPoint(x: window!.frame.width / 2 - submitButton.frame.size.width / 2, y: 50)
		window?.contentView?.addSubview(submitButton)
	}
	
	func generateTextLabel(text: String, fontSize: CGFloat, y: CGFloat) -> NSTextField {
		let textLabel: NSTextField = NSTextField()
		
		return textLabel
	}

}
