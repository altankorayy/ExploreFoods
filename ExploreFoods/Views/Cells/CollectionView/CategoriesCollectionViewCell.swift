//
//  CategoriesCollectionViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 3.03.2024.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCollectionViewCell"
    
    private lazy var categoriesTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test Food"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var categoriesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        categoriesTitle.text = nil
        categoriesImage.image = nil
    }
    
    public func configure() {
        
    }
    
    private func configureView() {
        backgroundColor = .secondarySystemBackground
        layer.masksToBounds = true
        layer.cornerRadius = 12
        
        addSubviews(categoriesTitle, categoriesImage)
        
        NSLayoutConstraint.activate([
            categoriesTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            categoriesTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            categoriesTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            categoriesTitle.heightAnchor.constraint(equalToConstant: 21),
            
            categoriesImage.topAnchor.constraint(equalTo: categoriesTitle.bottomAnchor, constant: 8),
            categoriesImage.widthAnchor.constraint(equalToConstant: 150),
            categoriesImage.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
}
