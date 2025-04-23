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
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var text: String
    @Relationship(inverse: \Comment.item) var comments: [Comment] = []

    init(id: UUID = UUID(), timestamp: Date, text: String) {
        self.id = id
        self.timestamp = timestamp
        self.text = text
    }
}
