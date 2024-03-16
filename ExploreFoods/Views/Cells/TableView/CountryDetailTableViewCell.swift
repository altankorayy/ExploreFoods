//
//  CountryDetailTableViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 13.03.2024.
//

import UIKit

class CountryDetailTableViewCell: UITableViewCell {

    static let identifier = "CountryDetailTableViewCell"
    
    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .label
        label.addShadow(shadowColor: UIColor.gray, shadowRadius: 3, shadowOpacity: 0.6, shadowOffset: CGSize(width: 2, height: 2))
        return label
    }()
    
    private let imageLoaderService: ImageLoaderService = ImageLoader()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
            mealImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mealImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mealImageView.widthAnchor.constraint(equalToConstant: 80),
            mealImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.centerYAnchor.constraint(equalTo: mealImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 23)
        ])
    }

}
