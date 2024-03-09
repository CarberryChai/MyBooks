//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }

    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
