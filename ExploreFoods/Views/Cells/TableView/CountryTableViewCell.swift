//
//  CountryTableViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 6.03.2024.
//

import UIKit

protocol CountryTableViewCellDelegate: AnyObject {
    func didSelectItemAt(with area: String, viewController: UIViewController)
}

class CountryTableViewCell: UITableViewCell {

    static let identifier = "CountryTableViewCell"
    
    weak var delegate: CountryTableViewCellDelegate?
    
    private lazy var countryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 55)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var areas = [String]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        countryCollectionView.frame = bounds
    }
    
    public func configure(with areas: [String]) {
        self.areas = areas
    }
    
    private func configureView() {
        contentView.addSubview(countryCollectionView)
        
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
    }
}

extension CountryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier, for: indexPath) as? CountryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: areas[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let selectedModel = areas[indexPath.item].components(separatedBy: " ").last else { return }
        let networkManagerService: NetworkManagerService = NetworkManager()
        let viewModel = MealDetailViewModel(networkManagerService: networkManagerService, area: selectedModel)
        let destinationVC = CountryDetailVC(viewModel: viewModel)
        
        viewModel.getMealsByArea()
        self.delegate?.didSelectItemAt(with: selectedModel, viewController: destinationVC)
    }
}
