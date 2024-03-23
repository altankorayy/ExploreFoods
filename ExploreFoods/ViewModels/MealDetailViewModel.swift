//
//  MealDetailViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 23.03.2024.
//

import Foundation
import Alamofire

protocol MealDetailViewModelDelegate: AnyObject {
    func updateView(model: [Meal])
    func updateViewWithError(error: AFError)
}

class MealDetailViewModel {
    
    weak var delegate: MealDetailViewModelDelegate?
    
    private let networkManagerService: NetworkManagerService
    
    var model: Meal?
    var area: String?
    var meal: String?
    
    init(networkManagerService: NetworkManagerService, meal: String? = nil, model: Meal? = nil, area: String? = nil) {
        self.networkManagerService = networkManagerService
        self.meal = meal
        self.model = model
        self.area = area
    }
    
    public func getMealsDetail() {
        guard let meal = meal else { return }
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
    
    func getDessertsDetail() {
        guard let model = model else { return }
        let endpoint = APIEndpoint.baseUrl.rawValue + APIEndpoint.searchMeal.rawValue + model.strMeal
        
        networkManagerService.getData(with: endpoint, responseType: Meals.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateView(model: data.meals)
            case .failure(let error):
                self?.delegate?.updateViewWithError(error: error)
            }
        }
    }
    
    public func getMealsByArea() {
        guard let area = area else { return }
        let endpoint = APIEndpoint.baseUrl.rawValue + APIEndpoint.byArea.rawValue + area
        
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
