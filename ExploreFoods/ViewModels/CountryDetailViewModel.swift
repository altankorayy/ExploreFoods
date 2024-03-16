//
//  CountryDetailViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 12.03.2024.
//

import Foundation
import Alamofire

protocol CountryDetailViewModelDelegate: AnyObject {
    func updateView(model: [Meal])
    func updateViewWithError(error: AFError)
}

class CountryDetailViewModel {
    
    weak var delegate: CountryDetailViewModelDelegate?
    
    private let networkManagerService: NetworkManagerService
    private var area: String
    
    init(networkManagerService: NetworkManagerService, area: String) {
        self.networkManagerService = networkManagerService
        self.area = area
    }
    
    public func getMealsByArea() {
        networkManagerService.getMealsByArea(with: area) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateView(model: data.meals)
            case .failure(let error):
                self?.delegate?.updateViewWithError(error: error)
            }
        }
    }
}
