//
//  Response.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

struct Response {
    static func handleResponse(for response: HTTPURLResponse?) -> Result<String> {
        guard let res = response else { return Result.failure(NetworkError.noResponse) }
        switch res.statusCode {
        case 200...299:
            return .success(NetworkError.success.rawValue)
        case 401:
            return .failure(NetworkError.authenticationError)
        case 400...499:
            return .failure(NetworkError.badRequest)
        case 500...599:
            return .failure(NetworkError.serverError)
        default:
            return .failure(NetworkError.failed)
        }
    }
}
