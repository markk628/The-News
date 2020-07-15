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
    let parameters = [
        "articles": "top-headlines",
        "contents": "top-headlines"
    ]
    var baseURL = "https://newsapi.org/v2/"
    
    func getNewsArticles(_ category:String, completion: @escaping (Result<[NewsArticle]>) -> ()) {
        let request = Request().makeRequest(for: .articles(category: category))
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
//        do {
//            let request = try Request.configureRequest(from: .category, with: parameters, and: .get, contains: nil)
//            urlSession.dataTask(with: request) { (data, response, error) in
//                if let response = response as? HTTPURLResponse, let data = data {
//                    let result = Response.handleResponse(for: response)
//                    switch result {
//                    case .success:
//                        let result = try? JSONDecoder().decode(NewsArticleList.self, from: data)
//                        completion(Result.success(result!.articles))
//                    case .failure:
//                        completion(Result.failure(NetworkError.decodingFailed))
//                    }
//                }
//            }.resume()
//        } catch {
//            completion(Result.failure(NetworkError.badRequest))
//        }
//    }
}
