//
//  MenuController.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/24.
//

import Cocoa
import Alamofire

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

class AppMenu: NSMenu, AppMenuDelegate {
	let window: AppWindow = AppWindow(contentRect: CGRect(x: 0.0, y: 0.0, width: 500, height: 200), styleMask: [.closable, .titled, .resizable], backing: .buffered, defer: false)
	var timer: Timer?
	let durationLabel: NSMenuItem = NSMenuItem(title: "", action: #selector(quit), keyEquivalent: "")
	let agendaLabel: NSMenuItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
	var meetingId: String?
	
	override init(title: String) {
		super.init(title: title)
		window.appMenuDelegate = self
		self.autoenablesItems = true
		let item: NSMenuItem = NSMenuItem(title: "入室する", action: #selector(openWindow), keyEquivalent: "")
		item.isEnabled = true
		item.target = self
		self.addItem(item)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func initMeetingManager(meetingTitle: String) {
		self.removeAllItems()
		// テキスト
		let meetingTitle: NSMenuItem = NSMenuItem(title: meetingTitle, action: nil, keyEquivalent: "")
		self.addItem(meetingTitle)
		self.addItem(agendaLabel)
		self.addItem(durationLabel)
		self.addItem(NSMenuItem.separator())
		// ボタン
		let nextAgendaButton: NSMenuItem = NSMenuItem(title: "次の議題へ", action: #selector(nextAgenda), keyEquivalent: "")
		nextAgendaButton.isEnabled = true
		nextAgendaButton.target = self
		self.addItem(nextAgendaButton)
		let finishMeetingButton: NSMenuItem = NSMenuItem(title: "会議の終了", action: #selector(finishMeeting), keyEquivalent: "")
		finishMeetingButton.isEnabled = true
		finishMeetingButton.target = self
		self.addItem(finishMeetingButton)
		let postponeAgendaButton: NSMenuItem = generateDelayOption(title: "延長", action: #selector(postponeAgenda))
		self.addItem(postponeAgendaButton)
		// 終了ボタンの追加
		let quitButton: NSMenuItem = NSMenuItem(title: "アプリを終了する", action: #selector(quit), keyEquivalent: "")
		quitButton.isEnabled = true
		quitButton.target = self
		self.addItem(quitButton)
		// タイマーの起動
		self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(polling), userInfo: nil, repeats: true)
		RunLoop.main.add(self.timer!, forMode: .common)
	}
	
	func generateDelayOption(title: String, action: Selector) -> NSMenuItem {
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
	func polling() {
		let url: URL = URL(string: "https://aika.lit-kansai-mentors.com/api/meeting/\(meetingId!)/status")!
		AF.request(url, method: .get).responseJSON { response in
			switch response.result {
			case .success:
				do {
                    let date: Double = Date().timeIntervalSince1970
					let json: Data = response.data!
					let decoder: JSONDecoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let objs: PollingResult = try decoder.decode(PollingResult.self, from: json)
                    self.agendaLabel.title = objs.data.title
                    self.durationLabel.title = "次の議題まで \(Int((Double(objs.data.duration) - date) / 60)):\(String(format: "%02d", (Int(Double(objs.data.duration) - date) % 60)))"
				} catch {
					print("error")
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	@objc
	func postponeAgenda(sender: NSMenuItem) {
		let url: URL = URL(string: "https://aika.lit-kansai-mentors.com/api/meeting/\(meetingId!)/reschedule")!
		let duration: Double = Double((sender.identifier?.rawValue)!)! * 60
		let parameters: [String: String] = [
			"dif": String(duration)
		]
		AF.request(url, method: .post, parameters: parameters).responseJSON { response in
			print(response.result)
			switch response.result {
			case .success:
				do {
					print("postpone agenda", response.result)
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	@objc
	func nextAgenda() {
		let url: URL = URL(string: "https://aika.lit-kansai-mentors.com/api/meeting/\(meetingId!)/agenda/next")!
		AF.request(url, method: .post).responseJSON { response in
			print(response.result)
			switch response.result {
			case .success:
				do {
					print("next agenda")
					print(response.result)
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	@objc
	func finishMeeting(sender: NSMenuItem) {
		let url: URL = URL(string: "https://aika.lit-kansai-mentors.com/api/meeting/\(meetingId!)/finish")!
		AF.request(url, method: .post).responseJSON { response in
			print(response.result)
			switch response.result {
			case .success:
				do {
					print("meeting ended", response.result)
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	@objc
	func openWindow(sender: NSMenuItem, window: AppWindow) {
		NSApp.activate(ignoringOtherApps: true)
		self.window.activeWindow()
	}
	
	@objc
	func joinMeeting(email: String, id: String) -> Bool {
		let parameters: [String: String] = [
			"email": email
		]
		let url: URL = URL(string: "https://aika.lit-kansai-mentors.com/api/meeting/\(id)/join_status_bar")!
		var isSucceeded: Bool = false
		AF.request(url, method: .post, parameters: parameters).responseJSON { response in
			print(response.result)
			switch response.result {
			case .success:
				do {
					let json: Data = response.data!
					let decoder: JSONDecoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let objs: Result = try decoder.decode(Result.self, from: json)
					self.initMeetingManager(meetingTitle: objs.data.meeting.title)
					isSucceeded = true
					self.meetingId = id
					self.window.close()
				} catch {
					print(error)
					print("meeting not found")
					isSucceeded = false
				}
			case .failure(let error):
				print(error)
				isSucceeded = false
			}
		}
		return isSucceeded
	}
	
	@objc
	func quit(sender: NSButton) {
		NSApplication.shared.terminate(self)
	}
}

// taguchike@taguchike.com
// 1ef372f88ede9ef196923d167a03b4c6
