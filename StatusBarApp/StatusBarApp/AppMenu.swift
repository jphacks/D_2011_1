//
//  MenuController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/24.
//

import Cocoa

class AppMenu: NSMenu {
	
	struct AppMenuItem {
		var title: String
		var action: Selector?
		var keyEquivalent: String
		init(title: String, action: Selector?, keyEquivalent: String) {
			self.title = title
			self.action = action
			self.keyEquivalent = keyEquivalent
		}
	}
	
	let window: AppWindow = AppWindow(contentRect: CGRect(x: 0.0, y: 0.0, width: 500, height: 200), styleMask: [.closable, .titled, .resizable], backing: .buffered, defer: false)
	
	override init(title: String) {
		super.init(title: title)
		var appMenuItems: [AppMenuItem] = []
		appMenuItems.append(AppMenuItem(title: "定例会議", action: nil, keyEquivalent: ""))
		appMenuItems.append(AppMenuItem(title: "我々の今後について", action: nil, keyEquivalent: ""))
		appMenuItems.append(AppMenuItem(title: "4:23", action: nil, keyEquivalent: ""))
		appMenuItems.append(AppMenuItem(title: "次の議題へ", action: #selector(nextAgenda), keyEquivalent: ""))
		appMenuItems.append(AppMenuItem(title: "会議の終了", action: #selector(finishMeeting), keyEquivalent: ""))
		appMenuItems.append(AppMenuItem(title: "入室する", action: #selector(enterMeeting), keyEquivalent: ""))
		for appMenuItem in appMenuItems {
			let item: NSMenuItem = NSMenuItem(title: appMenuItem.title, action: appMenuItem.action, keyEquivalent: appMenuItem.keyEquivalent)
			item.isEnabled = true
			item.target = self
			self.addItem(item)
		}
		self.autoenablesItems = true
		let postponeAgendaButton: NSMenuItem = generateMenu(title: "延長", action: #selector(postponeAgenda))
		let shortenAgendaButton: NSMenuItem = generateMenu(title: "短縮", action: #selector(shortenAgenda))
		self.addItem(postponeAgendaButton)
		self.addItem(shortenAgendaButton)
		appMenuItems.append(AppMenuItem(title: "入室する", action: #selector(enterMeeting), keyEquivalent: ""))
		let item: NSMenuItem = NSMenuItem(title: "アプリを終了する", action: #selector(quit), keyEquivalent: "")
		item.isEnabled = true
		item.target = self
		self.addItem(item)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func generateMenu(title: String, action: Selector) -> NSMenuItem {
		let durationOptions: [String] = ["1", "3", "5", "10", "15", "20", "30", "40", "50", "60"]
		let button: NSMenuItem = NSMenuItem(title: title, action: nil, keyEquivalent: "")
		let buttonOptions: NSMenu = NSMenu()
		for option in durationOptions {
			let item: NSMenuItem = NSMenuItem(title: "\(option)分", action: action, keyEquivalent: "")
			item.identifier = NSUserInterfaceItemIdentifier(rawValue: option)
			item.isEnabled = true
			item.target = self
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
	func shortenAgenda(sender: NSMenuItem, title: String) {
		print(sender.identifier!.rawValue)
	}
	
	@objc
	func nextAgenda() {
		print("nextAgenda")
	}
	
	@objc
	func finishMeeting(sender: NSMenuItem) {
		
	}
	
	@objc
	func enterMeeting(sender: NSMenuItem, window: AppWindow) {
		NSApp.activate(ignoringOtherApps: true)
		self.window.activeWindow()
	}
	
	@objc
	func quit(sender: NSButton) {
		NSApplication.shared.terminate(self)
	}
}
