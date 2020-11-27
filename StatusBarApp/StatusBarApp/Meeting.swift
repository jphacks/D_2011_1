//
//  Meeting.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/28.
//

import Foundation

struct Result: Codable {
	let data: ResponseData
}

struct ResponseData: Codable {
	let isJoining: Bool
	let meeting: Meeting
}

struct Meeting: Codable {
	let title: String
}

struct PollingResult: Codable {
	let data: PollingResponseData
}

struct PollingResponseData: Codable {
	let title: String
	let duration: Int
}
