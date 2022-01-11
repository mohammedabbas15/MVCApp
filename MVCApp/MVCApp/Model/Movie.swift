//
//  Movie.swift
//  MVCApp
//
//  Created by iAskedYou2nd on 6/30/21.
//

import Foundation

struct PageResult: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case page, results
    }
}

struct Movie: Decodable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: String
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case posterURL = "poster_path"
        case releaseDate = "release_date"
        case id, overview
    }
    
}
