//
//  UserData.swift
//  CodeBaseAutolayout
//
//  Created by Minjae Kim on 11/5/23.
//

import Foundation

class UserData: Decodable {
	var userName: String
	var userJob: String
	var userContent: String
	
	init(userName: String, userJob: String, userContent: String) {
		self.userName = userName
		self.userJob = userJob
		self.userContent = userContent
	}
	
	private enum CodingKeys: String, CodingKey {
			case userName = "name"
			case userJob = "job"
			case userContent = "content"
		}
}
