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
    
    func getNewsArticles(_ category: String, completion: @escaping (Result<[NewsArticle]>) -> ()) {
        let request = Request().makeRequest(for: .articles(category: category))
        urlSession.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, let data = data {
                let result = Response.handleResponse(for: response)
                switch result {
                case .success:
                    let result = try? JSONDecoder().decode(NewsArticleList.self, from: data)
                    DispatchQueue.main.async {
                        completion(Result.success(result!.articles))
                    }
                case .failure:
                    completion(Result.failure(NetworkError.decodingFailed))
                }
            }
        }.resume()
    }
}
