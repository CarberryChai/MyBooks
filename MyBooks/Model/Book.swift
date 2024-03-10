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
    // when you want to use a different name for this attribute, use the @Attribute(originalName:) to do a light imigration
    @Attribute(originalName: "summary")
    var synopsis: String
    var rating: Int
    var status: Status.RawValue
    // when you want to add a new attribute, you can use optional type or use the default value
    var recomendedBy: String = ""
    var quotes: [Quote]?

    init(
        title: String,
        author: String,
        dateAdded: Date = .now,
        dateStarted: Date = .distantPast,
        dateCompleted: Date = .distantPast,
        synopsis: String = "",
        rating: Int = 0,
        status: Status = .OnShelf,
        recomendedBy: String = ""
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.synopsis = synopsis
        self.rating = rating
        self.status = status.rawValue
        self.recomendedBy = recomendedBy
    }

    var icon: Image {
        switch Status(rawValue: status)! {
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
