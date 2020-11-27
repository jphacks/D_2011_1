//
//  NSWindowController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/24.
//

@objc protocol AppMenuDelegate {
	func joinMeeting(email: String, id: String) -> Bool
}

import Cocoa
import Alamofire

class AppWindow: NSWindow {
	let idTextField: NSTextField = NSTextField()
	let emailTextField: NSTextField = NSTextField()
	let popoverLabel: NSTextField = NSTextField()
	let errorLabel: NSTextField = NSTextField()
	var submitButton: NSButton = NSButton()
	
	weak var appMenuDelegate: AppMenuDelegate?
	
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
		
		emailTextField.frame.size = CGSize(width: self.frame.width / 2, height: 20)
		emailTextField.frame.origin = CGPoint(x: self.frame.width / 2 - emailTextField.frame.size.width / 2, y: 120)
		emailTextField.placeholderString = "メールアドレス"
		self.contentView?.addSubview(emailTextField)
		
		idTextField.frame.size = CGSize(width: self.frame.width / 2, height: 20)
		idTextField.frame.origin = CGPoint(x: self.frame.width / 2 - idTextField.frame.size.width / 2, y: 90)
		idTextField.placeholderString = "ミーティングID"
		self.contentView?.addSubview(idTextField)
		
		let submitButton: NSButton = NSButton()
		submitButton.title = "入室する"
		submitButton.font = NSFont.labelFont(ofSize: 16)
		submitButton.bezelStyle = .rounded
		submitButton.sizeToFit()
		submitButton.identifier = NSUserInterfaceItemIdentifier(rawValue: "submitButton")
		submitButton.frame.origin = CGPoint(x: self.frame.width / 2 - submitButton.frame.size.width / 2, y: 50)
		submitButton.action = #selector(joinMeeting)
		self.contentView?.addSubview(submitButton)
	}
	
	func activeWindow() {
		initDefaultUI()
		self.orderFront(nil)
		self.center()
	}
	
	@objc
	func joinMeeting() {
		let isJoined: Bool = appMenuDelegate!.joinMeeting(email: emailTextField.stringValue, id: idTextField.stringValue)
		if !isJoined {
			errorLabel.frame.size = CGSize(width: self.frame.width / 2, height: 20)
			errorLabel.stringValue = "ミーティングIDかメールアドレスが見つかりません"
			errorLabel.font = NSFont.labelFont(ofSize: 12)
			errorLabel.sizeToFit()
			errorLabel.frame.origin = CGPoint(x: self.frame.width / 2 - errorLabel.frame.size.width / 2, y: 30)
			errorLabel.alignment = .center
			errorLabel.isEditable = false
			errorLabel.isBordered = false
			errorLabel.drawsBackground = false
			self.contentView?.addSubview(errorLabel)
		}
	}
}

extension AppWindow {
	override func close() {
		self.orderOut(NSApp)
	}
}
