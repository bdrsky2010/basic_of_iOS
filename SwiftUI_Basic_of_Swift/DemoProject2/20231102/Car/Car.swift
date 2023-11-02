//
//  Car.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

// 자동차 모델을 나타내는 Car 구조체 선언
struct Car: Codable, Identifiable {
	var id: String
	var name: String
	
	var description: String
	var isHybrid: Bool
	
	var imageName: String
}
