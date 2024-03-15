//
//  DetailBook.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import SwiftUI

struct DetailBook: View {
    @Bindable var book: Book
    var body: some View {
        Form {
            TextField("Book Title", text: $book.title)
            TextField("Author", text: $book.author)
            Picker("Status", selection: $book.status) {
                ForEach(Status.allCases) { status in
                    Text(status.description).tag(status.rawValue)
                }
            }
            DatePicker("Date Added", selection: $book.dateAdded, displayedComponents: .date)
            if Status(rawValue: book.status) == .InProgress || Status(rawValue: book.status) == .Completed {
                DatePicker("Date Started", selection: $book.dateStarted, in: book.dateAdded...Date.now, displayedComponents: .date)
            }
            if Status(rawValue: book.status) == .Completed {
                DatePicker("Date Completed", selection: $book.dateCompleted, in: book.dateStarted...Date.now, displayedComponents: .date)
            }

            LabeledContent {
                RatingView(rating: $book.rating)
            } label: {
                Text("Rating")
            }

            LabeledContent {
                TextField("name", text: $book.recomendedBy)
            } label: {
                Text("Recommended By :")
            }

            Section(header: Text("Synopsis")) {
                TextEditor(text: $book.synopsis)
                    .frame(height: 200)
            }

            if let genres = book.genres {
                ViewThatFits(in:.horizontal) {
                    GenresStack(genres: genres)
                    ScrollView(.horizontal) {
                        GenresStack(genres: genres)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .navigationTitle("New Book")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 50) {
                NavigationLink {
                    QuotesListView(book: book)
                } label: {
                    let count = book.quotes?.count ?? 0
                    Label("^[\(count) Quotes](inflect:true)", systemImage: "quote.opening")
                }

                NavigationLink {
                    GenresView(book: book)
                } label: {
                    let count = book.genres?.count ?? 0
                    Label("^[\(count) Genres](inflect:true)", systemImage: "tag")
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genre.samples
    preview.addExamples(books)
    preview.addExamples(genres)
    // books[4].genres?.append(genres[0])
    return NavigationStack {
        DetailBook(book: books[4])
            .modelContainer(preview.container)
    }
}
