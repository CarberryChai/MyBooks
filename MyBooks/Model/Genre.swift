//
//  Genre.swift
//  MyBooks
//
//  Created by changlin on 2024/3/11.
//

import SwiftData
import SwiftUI

@Model
class Genre {
    var name: String
    var color: String
    var books: [Book]?

    init(name: String, color: String) {
        self.name = name
        self.color = color
    }

    var hexColor: Color {
        Color(hex: color) ?? .green
    }
}
