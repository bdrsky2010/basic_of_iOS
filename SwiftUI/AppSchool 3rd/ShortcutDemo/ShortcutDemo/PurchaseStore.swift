//
//  PurchaseStore.swift
//  ShortcutDemo
//
//  Created by Minjae Kim on 1/12/24.
//

import SwiftUI

struct PurchaseStore {
	@AppStorage("demostorage", store: UserDefaults(suiteName: "YOUR APP GROUP NAME HERE")) var store: Data = Data()
	
	var purchases: [Purchase] = []
	
	init() {
		purchases = getPurchases()
	}
	
	func getPurchases() -> [Purchase] {
		var result: [Purchase] = []
		let decoder = JSONDecoder()
		
		if let history = try? decoder.decode(PurchaseData.self, from: store) {
			result = history.purchases
		}
		return result
	}
	
	func update(purchaseData: PurchaseData) -> Bool {
		var result = true
		let encoder = JSONEncoder()
		
		if let data = try? encoder.encode(purchaseData) {
			store = data
		} else {
			result = false
		}
		return result
	}
}
