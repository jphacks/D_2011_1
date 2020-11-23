//
//  AppDelegate.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/21.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
	let popover: NSPopover = NSPopover()
	let window: NSWindow = NSWindow(contentRect: CGRect(x: 0.0, y: 0.0, width: 500, height: 200), styleMask: [.closable, .titled, .resizable], backing: .buffered, defer: false)
	
	let idTextField: NSTextField = NSTextField()
	let popoverLabel: NSTextField = NSTextField()
	var submitButton: NSButton = NSButton()

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		if let button: NSStatusBarButton = statusItem.button {
			button.image = NSImage(named: NSImage.Name("timer"))
			button.action = #selector(togglePopover(_:))
		}
		popover.contentViewController = ViewController.newInstance()
		popover.animates = false
		initMenu()
	}
	
	@objc
	func togglePopover(_ sender: NSStatusItem) {
		if popover.isShown {
			closePopover(sender: sender)
		} else {
			showPopover(sender: sender)
		}
	}
	
	func showPopover(sender: Any?) {
		if let button: NSStatusBarButton = statusItem.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
		}
	}
	
	func closePopover(sender: Any?) {
		popover.performClose(sender)
	}
	
	func initMenu() {
		let menu: NSMenu = NSMenu()
		menu.addItem(NSMenuItem(title: "定例会議", action: nil, keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "我々の今後について", action: nil, keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "4:23", action: nil, keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "次の議題へ", action: #selector(nextAgenda), keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "会議の終了", action: #selector(finishMeeting), keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "入室する", action: #selector(enterMeeting), keyEquivalent: ""))
		let postponeAgendaButton: NSMenuItem = generateMenu(title: "延長", action: #selector(postponeAgenda))
		let shortenAgendaButton: NSMenuItem = generateMenu(title: "短縮", action: #selector(shortenAgenda))
		menu.addItem(postponeAgendaButton)
		menu.addItem(shortenAgendaButton)
	
		statusItem.menu = menu
	}
	
	func generateMenu(title: String, action: Selector) -> NSMenuItem {
		let durationOptions: [String] = ["1", "3", "5", "10", "15", "20", "30", "40", "50", "60"]
		let button: NSMenuItem = NSMenuItem(title: title, action: nil, keyEquivalent: "")
		let buttonOptions: NSMenu = NSMenu()
		for option in durationOptions {
			let item: NSMenuItem = NSMenuItem(title: "\(option)分", action: action, keyEquivalent: "")
			item.identifier = NSUserInterfaceItemIdentifier(rawValue: option)
			buttonOptions.addItem(item)
		}
		button.submenu = buttonOptions
		return button
	}
	
	@objc
	func test(sender: NSMenuItem) {
		print(sender.identifier!.rawValue)
	}
	
	@objc
	func postponeAgenda(sender: NSMenuItem) {
		print(sender.identifier!.rawValue)
	}
	
	@objc
	func shortenAgenda(sender: NSMenuItem) {
		print(sender.identifier!.rawValue)
	}
	
	@objc
	func nextAgenda(sender: NSMenuItem) {
		
	}
	
	@objc
	func finishMeeting(sender: NSMenuItem) {
		
	}
	
	@objc
	func enterMeeting(sender: NSMenuItem) {
		NSApp.activate(ignoringOtherApps: true)
		initDefaultUI()
		window.makeKeyAndOrderFront(sender)
		window.center()
	}
	
	func initDefaultUI() {
		popoverLabel.frame.size = CGSize(width: window.frame.width, height: 30)
		popoverLabel.stringValue = "ミーティングIDを入力してください"
		popoverLabel.font = NSFont.labelFont(ofSize: 16)
		popoverLabel.sizeToFit()
		popoverLabel.frame.origin = CGPoint(x: window.frame.width / 2 - popoverLabel.frame.size.width / 2, y: 150)
		popoverLabel.alignment = .center
		popoverLabel.isEditable = false
		popoverLabel.isBordered = false
		popoverLabel.drawsBackground = false
		window.contentView?.addSubview(popoverLabel)
		
		idTextField.frame.size = CGSize(width: window.frame.width / 2, height: 20)
		idTextField.frame.origin = CGPoint(x: window.frame.width / 2 - idTextField.frame.size.width / 2, y: 100)
		window.contentView?.addSubview(idTextField)
		
		let submitButton: NSButton = NSButton()
		submitButton.title = "入室する"
		submitButton.font = NSFont.labelFont(ofSize: 16)
		submitButton.bezelStyle = .rounded
		submitButton.sizeToFit()
		submitButton.identifier = NSUserInterfaceItemIdentifier(rawValue: "submitButton")
		submitButton.frame.origin = CGPoint(x: window.frame.width / 2 - submitButton.frame.size.width / 2, y: 50)
		window.contentView?.addSubview(submitButton)
	}
	
}
