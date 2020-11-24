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

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		if let button: NSStatusBarButton = statusItem.button {
			button.image = NSImage(named: NSImage.Name("timer"))
		}
		let menu: NSMenu = AppMenu()
		statusItem.menu = menu
	}

}
