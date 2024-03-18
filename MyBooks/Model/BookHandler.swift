//
//  BookHandler.swift
//  MyBooks
//
//  Created by changlin on 2024/3/17.
//

import Foundation
import SwiftData

@ModelActor
actor BookHandler {
    @MainActor
    init(modelContainer: ModelContainer, mainActor _: Bool) {
        let modelContext = modelContainer.mainContext
        modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
        self.modelContainer = modelContainer
    }

    func deleteBooks(offsets: IndexSet, books: [Book]) {
        for index in offsets {
            modelContext.delete(books[index])
        }
    }

    @discardableResult
    func newBook(title: String, author: String) throws -> PersistentIdentifier {
        let book = Book(title: title, author: author)
        modelContext.insert(book)
        try modelContext.save()
        return book.persistentModelID
    }
}
