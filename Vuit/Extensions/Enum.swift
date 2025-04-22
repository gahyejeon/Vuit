//
//  Enum.swift
//  Vuit
//
//  Created by 내꺼다 on 4/21/25.
//

import Foundation

enum HomeStatus {
    case empty
    case populated([Item])
}


enum Route: Hashable {
    case newPost
    case editPost(item: Item)
}
