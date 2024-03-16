//
//  CategoriesCollectionViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 3.03.2024.
//

import UIKit
import Alamofire

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCollectionViewCell"
    
    private lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let imageLoaderService: ImageLoaderService = ImageLoader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        categoriesLabel.text = nil
        descriptionLabel.text = nil
        categoriesImage.image = nil
    }
    
    public func configure(with category: Category) {
        categoriesLabel.text = category.strCategory
        descriptionLabel.text = category.strCategoryDescription
        
        imageLoaderService.getImage(url: category.strCategoryThumb) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let imageData = imageData, let self = self else { return }
                
                DispatchQueue.main.async {
                    self.categoriesImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureView() {
        backgroundColor = .secondarySystemBackground
        layer.masksToBounds = true
        layer.cornerRadius = 12
        
        addSubviews(categoriesLabel, categoriesImage, descriptionLabel)
        
        NSLayoutConstraint.activate([
            categoriesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            categoriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            categoriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            categoriesLabel.heightAnchor.constraint(equalToConstant: 21),
            
            categoriesImage.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 8),
            categoriesImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesImage.heightAnchor.constraint(equalToConstant: 150),
            
            descriptionLabel.topAnchor.constraint(equalTo: categoriesImage.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
}
