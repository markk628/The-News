//
//  NewsArticleListViewController.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit

class NewsArticleListViewController: UIViewController {
    
    var category: String = "business"
    
    let newsArticleTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var newsArticles: [NewsArticle] = [] {
        didSet {
            newsArticleTableView.reloadData()
        }
    }
    
    var network = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateFeed()
        setTable()
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
    
    func setTable(){
        self.view.addSubview(newsArticleTableView)
        newsArticleTableView.register(NewsArticleCell.self, forCellReuseIdentifier: NewsArticleCell.identifier)
        newsArticleTableView.dataSource = self
        newsArticleTableView.delegate = self
        self.view.backgroundColor = .white
        newsArticleTableView.rowHeight = 125
        
        NSLayoutConstraint.activate([
            newsArticleTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            newsArticleTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            newsArticleTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newsArticleTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}

extension NewsArticleListViewController: UITableViewDelegate, UITableViewDataSource{
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
        let vc = NewsArticleViewController()
        //Assigning Title
        vc.newsTitle = news.title!
        //Assigning Content
        guard let newsContent = news.content else{
            print("No content")
            return
        }
        vc.news = newsContent
        guard let newsURL = news.url else {
            print("No URL found")
            return
        }
        vc.theNews = newsURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
