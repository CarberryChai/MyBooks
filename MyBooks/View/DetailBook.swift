//
//  DetailBook.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import SwiftUI

struct DetailBook: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var book: Book
    var body: some View {
        Form {
            TextField("Book Title", text: $book.title)
            TextField("Author", text: $book.author)
            DatePicker("Date Added", selection: $book.dateAdded, displayedComponents: .date)
        }
        .navigationTitle("New Book")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self, inMemory: true)
}
