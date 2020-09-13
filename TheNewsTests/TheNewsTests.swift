//
//  TheNewsTests.swift
//  TheNewsTests
//
//  Created by Mark Kim on 7/9/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import XCTest
@testable import TheNews

class TheNewsTests: XCTestCase {
    
    let categoryViewController = CategoryViewController()
    let newsArticleListViewController = NewsArticleListViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCategoryCells() {
        let categoryCount = categoryViewController.categories.count
        
        XCTAssert(categoryCount == 7)
    }
    
    func testNewsArticleList() {
        let newsArticlesCount = newsArticleListViewController.newsArticles.count
        
        XCTAssertEqual(newsArticlesCount, 0)
    }

}
