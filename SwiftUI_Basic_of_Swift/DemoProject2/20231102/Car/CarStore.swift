//
//  CarStore.swift
//  DemoProject2
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

class CarStore: ObservableObject {
	@Published var cars: [Car]
	
	init(cars: [Car] = []) {
		self.cars = cars
	}
}
