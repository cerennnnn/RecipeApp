//
//  APIService.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 7.12.2023.
//

import Foundation

protocol EndpointProtocol {
    var baseUrl: String {get}
    var path : String {get}
    var method : HttpMethod {get}
    var header : [String : String]? {get}
    func request () -> URLRequest
}

enum HttpMethod : String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData<T: Codable>(forEndpoint endpoint: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        let baseURL = "https://www.themealdb.com/api/json/v1/1/"
        
        
        if let url = URL(string: "\(baseURL)\(endpoint)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Hata kontrolü
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            }.resume()
        } else {
            completion(.failure(NetworkError.invalidURL))
        }
    }
}
