//
//  CountryMealDetailViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 20.03.2024.
//

import Foundation
import Alamofire

protocol CountryMealDetailViewModelDelegate: AnyObject {
    func updateView(model: [Meal])
    func updateViewWithError(error: AFError)
}

class CountryMealDetailViewModel {
    
    weak var delegate: CountryMealDetailViewModelDelegate?
    
    private let networkManagerService: NetworkManagerService
    var meal: String
    
    init(networkManagerService: NetworkManagerService, meal: String) {
        self.networkManagerService = networkManagerService
        self.meal = meal
    }
    
    public func getMealsDetail() {
        let endpoint = APIEndpoint.baseUrl.rawValue + APIEndpoint.searchMeal.rawValue + meal
        
        networkManagerService.getData(with: endpoint, responseType: Meals.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateView(model: data.meals)
            case .failure(let error):
                self?.delegate?.updateViewWithError(error: error)
            }
        }
    }
}
