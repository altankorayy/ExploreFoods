//
//  CategoryTableViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 6.03.2024.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    static let identifier = "CategoriesTableViewCell"
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 230)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var categoryModel = [Category]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        categoriesCollectionView.frame = bounds
    }
    
    public func configure(with model: [Category]) {
        self.categoryModel = model
        
        DispatchQueue.main.async { [weak self] in
            self?.categoriesCollectionView.reloadData()
        }
    }
    
    private func configureView() {
        contentView.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }

}

extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: categoryModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
