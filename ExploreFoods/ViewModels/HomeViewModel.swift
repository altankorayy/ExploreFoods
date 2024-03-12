//
//  HomeViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import UIKit
import Alamofire

protocol HomeViewModelDelegate: AnyObject {
    func updateViewArea(with area: [Meal])
    func updateViewCategories(with categories: [Category])
    func updateViewDesserts(with desserts: [Meal])
    func updateViewWithError(with error: AFError)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    private let networkManagerService: NetworkManagerService
    
    init(networkManagerService: NetworkManagerService) {
        self.networkManagerService = networkManagerService
    }
    
    
    func getCategories() {
        networkManagerService.getCategories { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateViewCategories(with: data.categories)
            case .failure(let error):
                self?.delegate?.updateViewWithError(with: error)
            }
        }
    }
    
    func getDesserts() {
        networkManagerService.getDesserts { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateViewDesserts(with: data.meals)
            case .failure(let error):
                self?.delegate?.updateViewWithError(with: error)
            }
        }
    }
}
