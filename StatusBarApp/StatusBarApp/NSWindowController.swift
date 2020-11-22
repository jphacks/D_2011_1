//
//  NSWindowController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/22.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

	override func windowDidLoad() {
		super.windowDidLoad()

		self.window?.delegate = self

		// Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

	}

	private func windowDidMiniaturize(notification: NSNotification) {
		print("Window minimized")
	}

	private func windowWillClose(notification: NSNotification) {
		print("Window closing")
	}
}
