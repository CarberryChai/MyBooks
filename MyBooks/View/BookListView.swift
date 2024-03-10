//
//  BookListView.swift
//  MyBooks
//
//  Created by changlin on 2024/3/10.
//

import SwiftData
import SwiftUI

struct BookListView: View {
    @Environment(\.modelContext) private var viewContext
    @Query private var books: [Book]
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
        case .title:
            [.init(\Book.title)]
        case .author:
            [.init(\Book.author)]
        case .status:
            [.init(\Book.status), .init(\Book.title)]
        }
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filterString)
                || book.author.localizedStandardContains(filterString)
                || filterString.isEmpty
        }
        _books = Query(filter: predicate, sort: sortDescriptors)
    }

    var body: some View {
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
    }

    private func deleteBooks(offsets: IndexSet) {
        for index in offsets {
            viewContext.delete(books[index])
        }
    }
}

extension BookListView {
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
