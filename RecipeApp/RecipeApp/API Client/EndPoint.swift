//
//  APIEndPoint.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 7.12.2023.
//

import Foundation

enum EndPoint {
    case categories
    case filter
    
    var endPoint: String {
        switch self {
        case .categories:
            return "categories.php"
        case .filter:
            return "filter.php"
        }
    }
}

extension EndPoint : EndpointProtocol {

    //https://www.themealdb.com/api/json/v1/1/categories.php
    var baseUrl: String {
        return "https://www.themealdb.com/api/json/v1"
    }
    
    var path: String {
        switch self {
        case .categories : return
            "/1/categories.php".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .filter : return "php?"
        }
    }
    //https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
    
    var method: HttpMethod {
        switch self {
        case .categories : return .get
        case .filter : return .post
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseUrl) else{
            fatalError("Invalid Error")
        }
        
        components.path += path

        if method == .post {
//            components.query = "api_key=d5e113f5b6281f6df8f17115a57581e4"
            components.query = "c="
        }

//        component.path = path
        var request = URLRequest(url: components.url!)
        request.httpMethod =  method.rawValue
        return request
        
    }
}
