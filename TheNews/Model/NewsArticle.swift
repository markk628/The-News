//
//  NewsArticle.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation

struct NewsArticle: Decodable {
    var title: String?
    var url: String?
    var urlToImage: String?
    var content: String?
}

struct NewsArticleList: Decodable {
   var articles: [NewsArticle]
}
