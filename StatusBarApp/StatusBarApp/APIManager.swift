//
//  APIManager.swift
//  StatusBarApp
//
//  Created by tomoya tanaka on 2020/11/26.
//

import Foundation
import Alamofire

func postRequest(url: URLConvertible, parameters: [String: String]) {
	let request: DataRequest = AF.request(url,
										  method: .post,
										  parameters: parameters,
										  encoding: JSONEncoding.default, headers: nil)
	request.responseJSON { response in
		print(response)
	}
}
//
//func enterMeeting(url: String, parameters: [String: String] = ["": ""]) {
//	let url: URL = URL(string: url)!
//	AF.request(url, method: .post, parameters: parameters).responseJSON { response in
//		print(response.result)
//		switch response.result {
//		case .success:
//			do {
//				let json: Data = response.data!
//				let decoder: JSONDecoder = JSONDecoder()
//				decoder.keyDecodingStrategy = .convertFromSnakeCase
//				let objs: Result = try decoder.decode(Result.self, from: json)
//				print(objs.data.isJoining)
//		print(objs.data.meeting.title)
//			} catch {
//				print(error)
//			}
//		case .failure(let error):
//			print(error)
//		}
//	}
//}
