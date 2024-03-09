//
//  RatingView.swift
//  MyBooks
//
//  Created by changlin on 2024/3/9.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var body: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(index <= rating ? .yellow : .gray)
                    .onTapGesture {
                        rating = rating == index ? 0 : index
                    }
            }
        }
    }
}

struct StaticRatingView: View {
    let rating: Int
    var body: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(index <= rating ? .yellow : .gray)
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(3))
}
