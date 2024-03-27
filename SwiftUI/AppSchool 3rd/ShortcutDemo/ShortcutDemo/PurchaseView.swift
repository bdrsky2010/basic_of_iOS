//
//  PurchaseView.swift
//  ShortcutDemo
//
//  Created by Minjae Kim on 1/12/24.
//

import SwiftUI

struct PurchaseView: View {
	
	@State var symbol: String = ""
	@State var quantity: String = ""
	@State var status: String = "Enter symbol and quantity"
	
	@State var purchaseData: PurchaseData = PurchaseData()
	
	@AppStorage("demostorage", store: UserDefaults(suiteName: "YOUR APP GROUP NAME HERE")) var store: Data = Data()
	
	@Environment(\.scenePhase) private var scenePhase
	
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
	
	private func buyStock() {
		if symbol == "" || quantity == "" {
			status = "Please enter a symbol and quantity"
		} else {
			if purchaseData.saveTransaction(symbol: symbol, quantity: quantity) {
				status = "Purchase completed"
			}
		}
	}
}

#Preview {
    PurchaseView()
}
