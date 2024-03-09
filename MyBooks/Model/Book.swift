//
//  Book.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import SwiftUI
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var status: Status

    init(
        title: String,
        author: String,
        dateAdded: Date = .now,
        dateStarted: Date = .distantPast,
        dateCompleted: Date = .distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .OnShelf
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }

    var icon: Image {
        switch status {
        case .OnShelf: return Image(systemName: "checkmark.diamond.fill")
        case .InProgress: return Image(systemName: "book.fill")
        case .Completed: return Image(systemName: "books.vertical.fill")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case OnShelf, InProgress, Completed
    var id: Self { self }

    var description: String {
        switch self {
        case .OnShelf: return "On Shelf"
        case .InProgress: return "In Progress"
        case .Completed: return "Completed"
        }
    }
}
