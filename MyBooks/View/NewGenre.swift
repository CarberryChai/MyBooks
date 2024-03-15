//
//  NewGenre.swift
//  MyBooks
//
//  Created by changlin on 2024/3/15.
//

import SwiftUI

struct NewGenre: View {
    @State private var name = ""
    @State private var color: Color = .red
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                ColorPicker("Color", selection: $color, supportsOpacity: false)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        let newGenre = Genre(name: name, color: color.toHexString()!)
                        modelContext.insert(newGenre)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Genre")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewGenre()
}
