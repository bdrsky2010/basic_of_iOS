//
//  PurchaseData.swift
//  ShortcutDemo
//
//  Created by Minjae Kim on 1/12/24.
//

import Foundation

struct PurchaseData: Codable {
	var purchases: [Purchase]
	
	init() {
		purchases = []
	}
	
	mutating func refresh() {
		purchases = PurchaseStore().getPurchases()
	}
	
	mutating func saveTransaction(symbol: String, quantity: String) -> Bool {
		let formatter = DateFormatter()
		formatter.dateStyle = DateFormatter.Style.medium
		formatter.timeStyle = DateFormatter.Style.medium
		
		let timeStamp = formatter.string(from: Date())
		
		purchases.append(Purchase(symbol: symbol, quantity: quantity, timestamp: timeStamp))
		
		return PurchaseStore().update(purchaseData: self)
	}
}
