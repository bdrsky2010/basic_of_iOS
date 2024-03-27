//
//  Item.swift
//  SwiftDataDemo
//
//  Created by Minjae Kim on 12/28/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
