//
//  ContentView.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var viewContext
    @Query(sort: \Book.title) private var books: [Book]
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("Enter your book.", systemImage: "book.fill")
                } else {
                    List {
                        ForEach(books) { book in
                            bookRow(book)
                        }
                        .onDelete(perform: deleteBooks)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Books")
            .navigationDestination(for: Book.self, destination: { book in
                DetailBook(book: book)
            })
            .toolbar {
                Button(action: addNewBook) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
        }
    }

    private func addNewBook() {
        let newBook = Book(title: "", author: "")
        viewContext.insert(newBook)
        path.append(newBook)
    }

    private func deleteBooks(offsets: IndexSet) {
        for index in offsets {
            viewContext.delete(books[index])
        }
    }
}

extension ContentView {
    @ViewBuilder
    func bookRow(_ book: Book) -> some View {
        NavigationLink(value: book) {
            HStack(spacing: 10) {
                book.icon
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if book.rating > 0 {
                    StaticRatingView(rating: book.rating)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return ContentView().modelContainer(preview.container)
}
