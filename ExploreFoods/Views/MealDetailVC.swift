//
//  MealDetailVC.swift
//  ExploreFoods
//
//  Created by Altan on 23.03.2024.
//

import UIKit
import Alamofire

class MealDetailVC: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var mealImage: UIImageView = {
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
    
    private lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        label.text = "Instructions"
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
        label.backgroundColor = .secondarySystemBackground
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        return label
    }()
    
    private let viewModel: MealDetailViewModel?

    private let imageLoaderService: ImageLoaderService = ImageLoader()
    
    init(viewModel: MealDetailViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    private func updateView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubviews(mealImage, titleLabel, descriptionLabel, instructionsLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mealImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mealImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            mealImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            mealImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
            mealImage.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: mealImage.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            instructionsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            instructionsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            instructionsLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
        ])
    }
    
    public func configure(with category: Category) {
        titleLabel.text = category.strCategory
        descriptionLabel.text = category.strCategoryDescription
        
        imageLoaderService.getImage(url: category.strCategoryThumb) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.mealImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func configure(with meal: Meal) {
        titleLabel.text = meal.strMeal
        descriptionLabel.text = meal.strInstructions
        
        imageLoaderService.getImage(url: meal.strMealThumb) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.mealImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension MealDetailVC: MealDetailViewModelDelegate {
    func updateView(model: [Meal]) {
        if let meal = model.first {
            self.configure(with: meal)
        }
    }
    
    func updateViewWithError(error: Alamofire.AFError) {
        showAlertView(title: "Something went wrong", message: error.localizedDescription)
    }
}

