//
//  NewsArticleListViewController.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import SafariServices

class NewsArticleListViewController: UIViewController {
    
    var category: String = "business"
    let network = APIClient()
    
    var newsArticles: [NewsArticle] = [] {
        didSet {
            self.newsArticleTableView.reloadData()
        }
    }
    
    let newsArticleTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsArticleCell.self, forCellReuseIdentifier: NewsArticleCell.identifier)
        tableView.rowHeight = 130
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateFeed()
        setNewsArticlesTableView()
    }
    
    func updateFeed(){
        network.getNewsArticles(category) { result in
            switch result {
            case let .success(news):
                self.newsArticles = news
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func setNewsArticlesTableView() {
        self.view.addSubview(newsArticleTableView)
        newsArticleTableView.dataSource = self
        newsArticleTableView.delegate = self
        
        NSLayoutConstraint.activate([
            newsArticleTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            newsArticleTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            newsArticleTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newsArticleTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}

extension NewsArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsArticleCell.identifier, for: indexPath) as! NewsArticleCell
        let news = newsArticles[indexPath.row]
        cell.data = news
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsArticles[indexPath.row]
        guard let newsURL = news.url else {
            print("No URL found")
            return
        }
        let vc = SFSafariViewController(url: URL(string: newsURL)!)
        present(vc, animated: true)
    }
}
