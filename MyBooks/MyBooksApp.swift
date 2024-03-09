//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import SwiftData
import SwiftUI

@main
struct MyBooksApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }

    init() {
        let scheme = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: scheme)
        do {
            container = try ModelContainer(for: scheme, configurations: config)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
