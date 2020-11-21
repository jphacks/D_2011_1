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

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		if let button: NSStatusBarButton = statusItem.button {
			button.image = NSImage(named: NSImage.Name("timer"))
			button.action = #selector(AppDelegate.togglePopover(_:))
		}
		popover.contentViewController = ViewController.newInstance()
		popover.animates = false
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
}
