//
//  CountryDetailCollectionViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 18.03.2024.
//

import UIKit

class CountryDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CountryDetailCollectionViewCell"
    
    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.addShadow(shadowColor: UIColor.gray, shadowRadius: 3, shadowOpacity: 0.6, shadowOffset: CGSize(width: 2, height: 2))
        return label
    }()
    
    private let imageLoaderService: ImageLoaderService = ImageLoader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(model: Meal) {
        titleLabel.text = model.strMeal
        
        imageLoaderService.getImage(url: model.strMealThumb) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let imageData = imageData, let self = self else { return }
                
                DispatchQueue.main.async {
                    self.mealImageView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateView() {
        addSubviews(mealImageView, titleLabel)
        
        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mealImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mealImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            mealImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
