//
//  DessertTableViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 6.03.2024.
//

import UIKit

class DessertTableViewCell: UITableViewCell {

    static let identifier = "DessertTableViewCell"
    
    private lazy var dessertCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 100)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DessertCollectionViewCell.self, forCellWithReuseIdentifier: DessertCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var dessertsModel = [Meal]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        dessertCollectionView.frame = bounds
    }
    
    public func configure(with model: [Meal]) {
        self.dessertsModel = model
        
        DispatchQueue.main.async { [weak self] in
            self?.dessertCollectionView.reloadData()
        }
    }
    
    private func configureView() {
        contentView.addSubview(dessertCollectionView)
        
        dessertCollectionView.delegate = self
        dessertCollectionView.dataSource = self
    }

}

extension DessertTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dessertsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DessertCollectionViewCell.identifier, for: indexPath) as?  DessertCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: dessertsModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

