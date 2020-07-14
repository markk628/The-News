//
//  APIClient.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation

class APIClient {
    let urlSession = URLSession.shared
//    let parameters = [
//        
//    ]
    var baseURL = "https://newsapi.org/v2/"
    
    func getNewsArticles(_ category:String, completion: @escaping (Result<[NewsArticle]>) -> ()) {
        let request = makeRequest(for: .articles(category: category))
        urlSession.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, let data = data {
                let result = Response.handleResponse(for: response)
                switch result {
                case .success:
                    let result = try? JSONDecoder().decode(NewsArticleList.self, from: data)
                    completion(Result.success(result!.articles))
                case .failure:
                    completion(Result.failure(NetworkError.decodingFailed))
                }
            }
        }.resume()
    }
//    func getNewsArticles(_ category:String, completion: @escaping (Result<[NewsArticle]>) -> ()) {
//        let request = Request.configureRequest(from: .category, with: parameters, and: .get, contains: nil)
//        urlSession.dataTask(with: request) { (data, response, error) in
//            if let response = response as? HTTPURLResponse, let data = data {
//                let result = Response.handleResponse(for: response)
//                switch result {
//                case .success:
//                    let result = try? JSONDecoder().decode(NewsArticleList.self, from: data)
//                    completion(Result.success(result!.articles))
//                case .failure:
//                    completion(Result.failure(NetworkError.decodingFailed))
//                }
//            }
//        }.resume()
//    }

    
    enum EndPoints {
        case articles(category: String)
        case contents
        
        func getPath() -> String {
            switch self {
            case .articles:
                return "top-headlines"
            case .contents:
                return "top-headlines"
            }
        }
        
        func getHTTPMethod() -> String {
            return "GET"
        }
        
        func getHeaders(token: String) -> [String: String] {
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "X-Api-Key \(apiKey)",
                "Host": "newsapi.org"
            ]
        }
        
        func getParameters() -> [String:String] {
            switch self {
            case .articles(let category):
                return[
                    "country": "us",
                    "category": category,
                    "apiKey": apiKey
                ]
            case .contents:
                return[
                    "i": "i"
                ]
            }
        }
        
        func parametersToString() -> String {
            let parameterArray = getParameters().map { key, value in
                return "\(key)=\(value)"
            }
            return parameterArray.joined(separator: "&")
        }
    }
    
    private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        let fullURL = URL(string: baseURL.appending("\(endPoint.getPath())?\(endPoint.parametersToString())"))!
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = endPoint.getHTTPMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(token: apiKey)

        return request
    }
}
