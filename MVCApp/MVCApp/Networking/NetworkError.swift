//
//  NetworkError.swift
//  MVCApp
//
//  Created by iAskedYou2nd on 6/30/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badData
}

struct NetworkConstants {
    static let glaceonPic = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/471.png"
    static let moviePopular = "https://api.themoviedb.org/3/movie/popular?api_key=705f7bed4894d3adc718c699a8ca9a4f&page=1"
    static let imageBase = "https://image.tmdb.org/t/p/w500/"
}

