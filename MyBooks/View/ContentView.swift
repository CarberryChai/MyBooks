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
    @State private var createNewBook = false
    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("Enter your book.", systemImage: "book.fill")
                } else {
                    List {
                        ForEach(books) { book in
                            bookRow(book)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let item = books[index]
                                viewContext.delete(item)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Books")
            .toolbar {
                Button(action: {
                    createNewBook = true
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                })
            }
            .sheet(isPresented: $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

extension ContentView {
    @ViewBuilder
    func bookRow(_ book: Book) -> some View {
        NavigationLink {
            Text(book.title)
        } label: {
            HStack(spacing: 10) {
                book.icon
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if let rating = book.rating {
                    HStack {
                        ForEach(1 ... rating, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .imageScale(.small)
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self, inMemory: true)
}
