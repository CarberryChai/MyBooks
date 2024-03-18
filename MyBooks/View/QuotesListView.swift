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
    @State private var selectedQuote: Quote?
    private var isSelecting: Bool {
        selectedQuote != nil
    }

    var body: some View {
        Form {
            Section(header: Text("Add Quote")) {
                LabeledContent {
                    TextField("Page#", text: $page)
                } label: {
                    Text("Page")
                }
                TextEditor(text: $text)
                    .frame(height: 100)

                HStack {
                    if isSelecting {
                        Button("Cancel") {
                            page = ""
                            text = ""
                            selectedQuote = nil
                        }
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                    Button("\(isSelecting ? "Update" : "Create")") {
                        createOrUpdateQuote()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(text.isEmpty)
                }
            }
            Section(header: Text("Quotes")) {
                if let quotes = book.quotes {
                    ForEach(quotes) { quote in
                        VStack(alignment: .leading) {
                            Text(quote.created, format: .dateTime.day().month().year())
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(quote.text)
                            HStack {
                                Spacer()
                                if let page = quote.page {
                                    Text("Page: \(page)")
                                        .font(.caption)
                                }
                            }
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            selectedQuote = quote
                            page = quote.page ?? ""
                            text = quote.text
                        }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            let quote = quotes[index]
                            if let bookQuotes = book.quotes, let idx = bookQuotes.firstIndex(where: { $0 == quote }){
                                book.quotes?.remove(at: idx)
                            }
                            context.delete(quote)
                        }
                    })
                }
            }
        }
        .navigationTitle("Quotes")
        .navigationBarTitleDisplayMode(.inline)
    }

    func createOrUpdateQuote() {
        if isSelecting {
            selectedQuote?.page = page
            selectedQuote?.text = text
            selectedQuote = nil
        } else {
            let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
            book.quotes?.append(quote)
        }
        page = ""
        text = ""
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    preview.addExamples(books)
    return NavigationStack {
        QuotesListView(book: books[2])
            .modelContainer(preview.container)
    }
}
