//
//  GenreSamples.swift
//  MyBooks
//
//  Created by changlin on 2024/3/11.
//

import Foundation

//extension Genre {
//    static var samples = [
//        Genre(name: "Fiction", color: "#FF0000"),
//        Genre(name: "Non-fiction", color: "#00FF00"),
//        Genre(name: "Mystery", color: "#0000FF"),
//        Genre(name: "Fantasy", color: "#FFFF00"),
//        Genre(name: "Science Fiction", color: "#00FFFF"),
//        Genre(name: "Romance", color: "#FF00FF"),
//        Genre(name: "Horror", color: "#000000")
//    ]
//}

extension Genre {
    static var samples: [Genre] {
        [
            Genre(name: "Fiction", color: "00FF00"),
            Genre(name: "Non Fiction", color: "0000FF"),
            Genre(name: "Romance", color: "FF0000"),
            Genre(name: "Thriller", color: "000000")
        ]
    }
}
