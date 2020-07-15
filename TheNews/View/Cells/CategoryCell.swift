//
//  CategoryCell.swift
//  TheNews
//
//  Created by Mark Kim on 7/13/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier: String = "CategoryCell"
    
    var category: Category? {
        didSet {
            guard let category = category else { return }
            categoryTextLabel.text = category.categoryName
        }
    }
    
    var categoryTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCategoryCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCategoryCell() {
        self.backgroundColor = UIColor(red: 0.69, green: 1.70, blue: 2.42, alpha: 1.0)
        self.layer.cornerRadius = 10.0
        self.contentView.addSubview(categoryTextLabel)
        
        NSLayoutConstraint.activate([
            categoryTextLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            categoryTextLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
