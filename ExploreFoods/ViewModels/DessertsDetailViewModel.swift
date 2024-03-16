//
//  DessertsDetailViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 16.03.2024.
//

import Foundation
import Alamofire

protocol DessertsDetailViewModelDelegate: AnyObject {
    func updateView(with model: [Meal])
    func updateViewError(with error: AFError)
}

class DessertsDetailViewModel {
    
    private let networkManagerService: NetworkManagerService
    private var model: Meal
    
    weak var delegate: DessertsDetailViewModelDelegate?
    
    init(networkManagerService: NetworkManagerService, model: Meal) {
        self.networkManagerService = networkManagerService
        self.model = model
    }
    
    func getDessertsDetail() {
        networkManagerService.getDessertsDetail(with: model.strMeal) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateView(with: data.meals)
            case .failure(let error):
                self?.delegate?.updateViewError(with: error)
            }
        }
    }
}
