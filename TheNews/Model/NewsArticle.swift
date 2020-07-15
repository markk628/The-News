//
//  NewsArticle.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation

//struct NewsArticle: Codable {
//    var title: String?
//    var url: String?
//    var urlToImage: String?
//    var content: String?
//
//    enum NewsArticleCodingKeys: String, CodingKey {
//        case title
//        case url
//        case urlToImage
//        case content
//    }
//
//    init(from decoder: Decoder) throws {
//        let newsArticleContainer = try decoder.container(keyedBy: NewsArticleCodingKeys.self)
//        title = try newsArticleContainer.decode(String.self, forKey: .title)
//        url = try newsArticleContainer.decode(String.self, forKey: .url)
//        urlToImage = try newsArticleContainer.decode(String.self, forKey: .urlToImage)
//        content = try newsArticleContainer.decode(String.self, forKey: .content)
//    }
//}

//struct NewsArticleList: Codable {
//    let status: String
//    let totalResults: Int
//    let articles: [NewsArticle]
//
//    enum NewsArticleListCodingKeys: String, CodingKey {
//        case status
//        case totalResults
//        case articles
//    }
//
//    init(from decoder: Decoder) throws {
//        let newsArticleListContainer = try decoder.container(keyedBy: NewsArticleListCodingKeys.self)
//        status = try newsArticleListContainer.decode(String.self, forKey: .status)
//        totalResults = try newsArticleListContainer.decode(Int.self, forKey: .totalResults)
//        articles = try newsArticleListContainer.decode([NewsArticle].self, forKey: .articles)
//    }
//}

struct NewsArticle: Decodable {
    var title: String?
    var url: String?
    var urlToImage: String?
    var content: String?
}

struct NewsArticleList: Decodable {
   var articles: [NewsArticle]
}
