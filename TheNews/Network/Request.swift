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

public enum Route: String {
    case category = "category"
}

struct Request {
    static let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
    ]
    var baseURL = "https://newsapi.org/v2/"
    
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
    
    static func configureRequest(from route: Route, with parameters: [String: Any], and method: HTTPMethod, contains body: Data?) throws -> URLRequest {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=\(route.rawValue)") else { fatalError("Error while unwrapping url") }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        return request
    }
    
    static func configureParametersAndHeaders(parameters: [String: Any]?, headers: [String: String]?, request: inout URLRequest) throws {
        do{
            if let headers = headers, let parameters = parameters{
                try Encoder.encodeParameters(for: &request, with: parameters)
                try Encoder.setHeaders(for: &request, with: headers)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
    func makeRequest(for endPoint: EndPoints) -> URLRequest {
        let fullURL = URL(string: baseURL.appending("\(endPoint.getPath())?\(endPoint.parametersToString())"))!
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = endPoint.getHTTPMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(token: apiKey)

        return request
    }
}
