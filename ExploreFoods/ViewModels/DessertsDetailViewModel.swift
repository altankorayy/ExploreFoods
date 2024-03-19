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
    
    weak var delegate: DessertsDetailViewModelDelegate?
    
    private let networkManagerService: NetworkManagerService
    
    private var model: Meal
    
    init(networkManagerService: NetworkManagerService, model: Meal) {
        self.networkManagerService = networkManagerService
        self.model = model
    }
    
    func getDessertsDetail() {
        let endpoint = APIEndpoint.baseUrl.rawValue + APIEndpoint.searchMeal.rawValue + model.strMeal
        
        networkManagerService.getData(with: endpoint, responseType: Meals.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateView(with: data.meals)
            case .failure(let error):
                self?.delegate?.updateViewError(with: error)
            }
        }
    }
}
