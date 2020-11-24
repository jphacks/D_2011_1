//
//  NSWindowController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/24.
//

import Cocoa
import Alamofire

class NSWindowController: NSWindow {
	let idTextField: NSTextField = NSTextField()
	let popoverLabel: NSTextField = NSTextField()
	var submitButton: NSButton = NSButton()
	
	func initDefaultUI() {
		popoverLabel.frame.size = CGSize(width: self.frame.width, height: 30)
		popoverLabel.stringValue = "ミーティングIDを入力してください"
		popoverLabel.font = NSFont.labelFont(ofSize: 16)
		popoverLabel.sizeToFit()
		popoverLabel.frame.origin = CGPoint(x: self.frame.width / 2 - popoverLabel.frame.size.width / 2, y: 150)
		popoverLabel.alignment = .center
		popoverLabel.isEditable = false
		popoverLabel.isBordered = false
		popoverLabel.drawsBackground = false
		self.contentView?.addSubview(popoverLabel)
		
		idTextField.frame.size = CGSize(width: self.frame.width / 2, height: 20)
		idTextField.frame.origin = CGPoint(x: self.frame.width / 2 - idTextField.frame.size.width / 2, y: 100)
		self.contentView?.addSubview(idTextField)
		
		let submitButton: NSButton = NSButton()
		submitButton.title = "入室する"
		submitButton.font = NSFont.labelFont(ofSize: 16)
		submitButton.bezelStyle = .rounded
		submitButton.sizeToFit()
		submitButton.identifier = NSUserInterfaceItemIdentifier(rawValue: "submitButton")
//		submitButton.action = #selector(apiTest)
		submitButton.frame.origin = CGPoint(x: self.frame.width / 2 - submitButton.frame.size.width / 2, y: 50)
		self.contentView?.addSubview(submitButton)
	}
	
	func openWindow(_ sender: NSMenuItem) {
		initDefaultUI()
		self.makeKeyAndOrderFront(sender)
		self.center()
	}
	
//	@objc
//	func apiTest() {
//		let url: URL = URL(string: "https://aika.lit-kansai-mentors.com/api/meeting")!
//		
//	}
	
}
