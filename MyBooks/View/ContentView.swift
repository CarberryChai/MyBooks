//
//  ContentView.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import SwiftData
import SwiftUI

enum SortOrder: String, CaseIterable, Identifiable {
    case title, author, status
    var id: Self { self }
}

struct ContentView: View {
    @Environment(\.modelContext) private var viewContext
    @State private var path = NavigationPath()
    @State private var sortBy: SortOrder = .status
    @State private var filter = ""
    var body: some View {
        NavigationStack(path: $path) {
            HStack {
                Spacer()
                Picker("", selection: $sortBy) {
                    ForEach(SortOrder.allCases) {
                        Text($0.rawValue.capitalized)
                            .tag($0)
                    }
                }
            }
            BookListView(sortOrder: sortBy, filterString: filter)
                .searchable(text: $filter, prompt: Text("Filter on title or author"))
                .navigationTitle("My Books")
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
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    preview.addExamples(Genre.samples)
    return ContentView().modelContainer(preview.container)
}
