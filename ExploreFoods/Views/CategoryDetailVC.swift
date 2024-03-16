//
//  CategoryDetailViewController.swift
//  ExploreFoods
//
//  Created by Altan on 13.03.2024.
//

import UIKit

class CategoryDetailVC: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .label
        label.addShadow(shadowColor: UIColor.black, shadowRadius: 3, shadowOpacity: 0.4, shadowOffset: CGSize(width: 1, height: 1))
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        return label
    }()
    
    private let imageLoaderService: ImageLoaderService = ImageLoader()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }

    private func updateView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubviews(categoryImage, titleLabel, descriptionLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            categoryImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            categoryImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            categoryImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
            categoryImage.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
        ])
    }
    
    public func configure(model: Category) {
        titleLabel.text = model.strCategory
        descriptionLabel.text = model.strCategoryDescription
        
        imageLoaderService.getImage(url: model.strCategoryThumb) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let imageData = imageData, let self = self else { return }
                
                DispatchQueue.main.async {
                    self.categoryImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

