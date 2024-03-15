//
//  GenresView.swift
//  MyBooks
//
//  Created by changlin on 2024/3/11.
//

import SwiftData
import SwiftUI

struct GenresView: View {
    @Environment(\.modelContext) private var modelContext
    var book: Book
    @Query(sort: \Genre.name) var genres: [Genre]
    @State private var show = false
    var body: some View {
        Group {
            if genres.isEmpty {
                ContentUnavailableView(label: {
                    Image(systemName: "bookmark.fill")
                        .font(.largeTitle)
                }, description: {
                    Text("You need to create some genres first.")
                }, actions: {
                    Button("Create Genre") {
                        show.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                })
            } else {
                List {
                    ForEach(genres) { genre in
                        HStack {
                            if let bookGenres = book.genres {
                                Button {
                                    addRemove(genre)
                                } label: {
                                    Image(systemName: bookGenres.contains(genre) ? "circle.fill" : "circle")
                                }
                                .foregroundStyle(genre.hexColor)
                            }
                            Text(genre.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            modelContext.delete(genres[index])
                        }
                    })
                }
            }
        }
        .navigationTitle("Genres")
        .overlay(alignment: .bottomTrailing) {
            Button {
                show = true
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .imageScale(.large)
                    .padding()
                    .background(.blue, in: .circle)
                    .offset(x: -15)
            }
        }
        .sheet(isPresented: $show, content: {
            NewGenre()
                .presentationDetents([.medium, .large])
        })
    }

    func addRemove(_ genre: Genre) {
        if let bookGenres = book.genres {
            if let idx = bookGenres.firstIndex(where: { $0.id == genre.id }) {
                book.genres?.remove(at: idx)
            } else {
                book.genres?.append(genre)
            }
        } else {
            book.genres?.append(genre)
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genre.samples
    preview.addExamples(books)
    preview.addExamples(genres)
//        books[1].genres?.append(genres[0])

    return GenresView(book: books[1]).modelContainer(preview.container)
}
