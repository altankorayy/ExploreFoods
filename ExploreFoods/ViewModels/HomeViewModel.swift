//
//  HomeViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import UIKit
import Alamofire

protocol HomeViewModelDelegate: AnyObject {
    func updateView(with model: [Meals])
    func updateViewWithError(with error: AFError)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    private let networkManagerService: NetworkManagerService
    
    init(networkManagerService: NetworkManagerService) {
        self.networkManagerService = networkManagerService
    }
    
    func getMealsByArea_TR() {
        networkManagerService.getMealsByArea(with: "Canadian") { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateView(with: data.meals)
            case .failure(let error):
                self?.delegate?.updateViewWithError(with: error)
            }
        }
    }
}
