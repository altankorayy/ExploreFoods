//
//  CountryCollectionViewCell.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CountryCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        
    }
    
    public func configure(with area: String) {
        titleLabel.text = area
    }
    
    private func configureView() {
        contentView.addSubview(titleLabel)
        
        layer.masksToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
