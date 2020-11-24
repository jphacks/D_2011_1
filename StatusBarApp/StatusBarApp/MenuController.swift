//
//  MenuController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/24.
//

import Cocoa

class AppMenu: NSMenu {
	
	override init(title: String) {
		super.init(title: title)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func initMenu() -> NSMenu {
		let menu: NSMenu = NSMenu()
		menu.addItem(NSMenuItem(title: "定例会議", action: nil, keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "我々の今後について", action: nil, keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "4:23", action: nil, keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "次の議題へ", action: #selector(self.nextAgenda), keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "会議の終了", action: #selector(AppMenu.finishMeeting), keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "入室する", action: #selector(enterMeeting), keyEquivalent: ""))
		let postponeAgendaButton: NSMenuItem = generateMenu(title: "延長", action: #selector(postponeAgenda))
		let shortenAgendaButton: NSMenuItem = generateMenu(title: "短縮", action: #selector(shortenAgenda))
		menu.addItem(postponeAgendaButton)
		menu.addItem(shortenAgendaButton)
		
		return menu
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
	func enterMeeting(sender: NSMenuItem, window: WindowController) {
		NSApp.activate(ignoringOtherApps: true)
		window.openWindow(sender)
	}
}
