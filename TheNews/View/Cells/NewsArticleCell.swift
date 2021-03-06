//
//  NewsArticleCell.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import Kingfisher

class NewsArticleCell: UITableViewCell {

    static let identifier = "NewsCell"
        
    var data: NewsArticle? {
        didSet {
            guard let data = data, let newsImg = data.urlToImage else { return }
            let imageUrl = URL(string: newsImg)
            newsImage.kf.setImage(with: imageUrl)
            self.newsTitle.text = data.title
        }
    }
    
    let newsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    let newsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10.0
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpNewsStack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpNewsStack() {
        self.addSubview(newsStack)
        NSLayoutConstraint.activate([
            newsStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            newsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            newsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            newsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            newsImage.widthAnchor.constraint(equalTo: self.newsImage.heightAnchor)
        ])
        newsStack.addArrangedSubview(newsTitle)
        newsStack.addArrangedSubview(newsImage)
    }
}
