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
		if let button: NSStatusBarButton = self.statusItem.button {
			button.image = NSImage(named: NSImage.Name("timer"))
			button.action = #selector(AppDelegate.togglePopover(_:))
		}
		self.popover.contentViewController = ViewController.newInstance()
		self.popover.animates = false
	}

	func applicationWillTerminate(_ aNotification: Notification) {
	}

	@objc func togglePopover(_ sender: NSStatusItem) {
		if self.popover.isShown {
			closePopover(sender: sender)
		} else {
			showPopover(sender: sender)
		}
	}
	
	func showPopover(sender: Any?) {
		if let button = self.statusItem.button {
			self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
		}
	}
	
	func closePopover(sender: Any?) {
		self.popover.performClose(sender)
	}
}

