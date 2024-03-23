//
//  CountryDetailVC.swift
//  ExploreFoods
//
//  Created by Altan on 12.03.2024.
//

import UIKit
import Alamofire

class CountryDetailVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CountryDetailVC.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CountryDetailCollectionViewCell.self, forCellWithReuseIdentifier: CountryDetailCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let viewModel: MealDetailViewModel
    var countryFoodModel = [Meal]()
    
    init(viewModel: MealDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        viewModel.getMealsByArea()
    }
    

    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                   heightDimension: .fractionalHeight(1)))
        let goupHeight = DeviceTypes.isiPhone8Standard ? 0.24 : 0.19
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .fractionalHeight(goupHeight)),
                                                       subitems: [item, item, item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension CountryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryFoodModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryDetailCollectionViewCell.identifier, for: indexPath) as? CountryDetailCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(model: countryFoodModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedModel = countryFoodModel[indexPath.row]
        let networkManagerService: NetworkManagerService = NetworkManager()
        let viewModel = MealDetailViewModel(networkManagerService: networkManagerService, meal: selectedModel.strMeal)
        let destinationVC = MealDetailVC(viewModel: viewModel)
        
        destinationVC.title = selectedModel.strMeal
        viewModel.getMealsDetail()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension CountryDetailVC: MealDetailViewModelDelegate {
    func updateView(model: [Meal]) {
        self.countryFoodModel = model
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func updateViewWithError(error: Alamofire.AFError) {
        showAlertView(title: "Error", message: error.localizedDescription)
    }
}
