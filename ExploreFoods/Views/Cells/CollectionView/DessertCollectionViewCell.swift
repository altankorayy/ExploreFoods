//
//  DessertCollectionViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 3.03.2024.
//

import UIKit

class DessertCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DessertCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
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
        titleLabel.text = nil
        foodImageView.image = nil
    }
    
    public func configure(with desserts: Meal) {
        titleLabel.text = desserts.strMeal
        
        imageLoaderService.getImage(url: desserts.strMealThumb) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let imageData = imageData, let self = self else { return }
                
                DispatchQueue.main.async {
                    self.foodImageView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureView() {
        addSubviews(titleLabel, foodImageView)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        layer.masksToBounds = true
    
        NSLayoutConstraint.activate([
            foodImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            foodImageView.widthAnchor.constraint(equalToConstant: 80),
            foodImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
}
