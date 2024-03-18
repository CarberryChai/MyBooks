//
//  PreviewContainer.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let scheme = Schema(models)
        do {
            container = try ModelContainer(for: scheme, configurations: config)
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }

    func addExamples(_ examples: [some PersistentModel]) {
        Task { @MainActor in
            for example in examples {
                container.mainContext.insert(example)
            }
        }
    }
}
