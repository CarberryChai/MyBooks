//
//  QuotesListView.swift
//  MyBooks
//
//  Created by changlin on 2024/3/10.
//

import SwiftData
import SwiftUI

struct QuotesListView: View {
    @Environment(\.modelContext) private var context
    let book: Book
    @State private var page = ""
    @State private var text = ""
    var body: some View {
        Form {
            Section(header: Text("Add Quote")) {
               LabeledContent {
                    TextField("#Page", text: $page)
                } label: {
                    Text("Page")
                }
                TextEditor(text: $text)
                    .frame(height: 100)

                Button("Create") {
                    let quote = Quote(text: text, page: page)
                    book.quotes?.append(quote)
                    page = ""
                    text = ""
                }
            }
            Section(header: Text("Quotes")) {
                if let quotes = book.quotes {
                    ForEach(quotes) { quote in
                        VStack(alignment: .leading) {
                            Text(quote.text)
                            if let page = quote.page {
                                Text("Page: \(page)")
                                    .font(.caption)
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            let quote = quotes[index]
                            book.quotes?.forEach({ q in
                                if q.id == quote.id {
                                    context.delete(quote)
                                }
                            })
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    preview.addExamples(books)
    return QuotesListView(book: books[2])
        .modelContainer(preview.container)
}
