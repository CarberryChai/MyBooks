//
//  Quote.swift
//  MyBooks
//
//  Created by changlin on 2024/3/10.
//

import Foundation
import SwiftData

@Model
class Quote {
    var created: Date = Date.now
    var text: String
    var page: String?
    var book: Book?

    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
}
