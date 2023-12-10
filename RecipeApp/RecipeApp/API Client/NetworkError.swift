//
//  NetworkError.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
