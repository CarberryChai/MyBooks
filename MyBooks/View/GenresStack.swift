//
//  GenresStack.swift
//  MyBooks
//
//  Created by changlin on 2024/3/15.
//

import SwiftUI

struct GenresStack: View {
    let genres: [Genre]
    var body: some View {
        HStack {
            ForEach(genres) { genre in
                Text(genre.name)
                    .padding(5)
                    .background(genre.hexColor)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
    }
}
