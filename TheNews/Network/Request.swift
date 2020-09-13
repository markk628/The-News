//
//  Request.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct Request {
    static let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
    ]
    var baseURL = "https://newsapi.org/v2/"
    
//    enum EndPoints {
//        case articles(category: String)
//        case contents
//
//        func getPath() -> String {
//            switch self {
//            case .articles:
//                return "top-headlines"
//            case .contents:
//                return "top-headlines"
//            }
//        }
//
//        func getHeaders() -> [String: String] {
//            return [
//                "Accept": "application/json",
//                "Content-Type": "application/json",
//                "Authorization": "X-Api-Key \(apiKey)",
//                "Host": "newsapi.org"
//            ]
//        }
//
//        func getParameters() -> [String: String] {
//            switch self {
//            case .articles(let category):
//                return[
//                    "country": "us",
//                    "category": category,
//                    "apiKey": apiKey
//                ]
//            case .contents:
//                return[
//                    "i": "i"
//                ]
//            }
//        }
//
//        func parametersToString() -> String {
//            let parameterArray = getParameters().map { key, value in
//                return "\(key)=\(value)"
//            }
//            return parameterArray.joined(separator: "&")
//        }
//    }
    enum EndPoints {
        case articles(category: String)
        
        func getPath() -> String {
            return "top-headlines"
        }
        
        func getHeaders() -> [String: String] {
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "X-Api-Key \(apiKey)",
                "Host": "newsapi.org"
            ]
        }
        
        func getParameters() -> [String: String] {
            switch self {
            case .articles(let category):
                return[
                    "country": "us",
                    "category": category,
                    "apiKey": apiKey
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
    
    func makeRequest(for endPoint: EndPoints) -> URLRequest {
        let fullURL = URL(string: baseURL.appending("\(endPoint.getPath())?\(endPoint.parametersToString())"))!
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.allHTTPHeaderFields = endPoint.getHeaders()
        
        return request
    }
}
