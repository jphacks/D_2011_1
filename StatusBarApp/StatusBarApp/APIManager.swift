//
//  APIManager.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/26.
//

import Foundation
import Alamofire

struct Meeting: Codable {
	let isJoining: Bool
	let title: String
	let agenda: Agenda
}

struct Agenda: Codable {
	let title: String
	let duration: Int
}

func postRequest(url: URLConvertible, parameters: [String: String]) {
	let request: DataRequest = AF.request(url,
										  method: .post,
										  parameters: parameters,
										  encoding: JSONEncoding.default, headers: nil)
	request.responseJSON { response in
		print(response)
	}
}

func setupStationSets(url: String, parameters: [String: String] = ["": ""]) {
	let url: URL = URL(string: url)!
	AF.request(url, method: .get, parameters: parameters).responseJSON { response in
		switch response.result {
		case .success:
			do {
				let result: Meeting = try JSONDecoder().decode(Meeting.self, from: response.data!)
				print(result)
			} catch {
				print(error)
			}
		case .failure(let error):
			print(error)
		}
	}
}
