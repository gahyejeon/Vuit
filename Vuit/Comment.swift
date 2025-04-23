//
//  Comment.swift
//  Vuit
//
//  Created by 내꺼다 on 4/23/25.
//

import Foundation
import SwiftData

@Model
class Comment {
    @Attribute(.unique) var id: UUID
    var text: String
    var createdAt: Date
    @Relationship var item: Item? 

    init(id: UUID = UUID(), text: String, createdAt: Date = .now, item: Item? = nil) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.item = item
    }
}
