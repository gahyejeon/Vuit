//
//  Item.swift
//  Vuit
//
//  Created by 내꺼다 on 4/14/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date = Date()
    var text: String = ""
    
    init(timestamp: Date = Date(), text: String) {
        self.timestamp = timestamp
        self.text = text
    }
}
