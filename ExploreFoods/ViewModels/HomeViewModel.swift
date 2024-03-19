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
    func updateViewSignOut(with state: Bool)
    func updateViewSignOutWithError(with error: FirebaseAuthError)
    func updateViewWithError(with error: AFError)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    private let networkManagerService: NetworkManagerService
    private let authManagerService: AuthManagerService
    
    init(networkManagerService: NetworkManagerService, authManagerService: AuthManagerService) {
        self.networkManagerService = networkManagerService
        self.authManagerService = authManagerService
    }
    
    
    func getCategories() {
        let endpoint = APIEndpoint.baseUrl.rawValue + APIEndpoint.categories.rawValue
        
        networkManagerService.getData(with: endpoint, responseType: Categories.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateViewCategories(with: data.categories)
            case .failure(let error):
                self?.delegate?.updateViewWithError(with: error)
            }
        }
    }
    
    func getDesserts() {
        let endpoint = APIEndpoint.baseUrl.rawValue + APIEndpoint.desserts.rawValue
        
        networkManagerService.getData(with: endpoint, responseType: Meals.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.updateViewDesserts(with: data.meals)
            case .failure(let error):
                self?.delegate?.updateViewWithError(with: error)
            }
        }
    }
    
    func logoutUser() {
        authManagerService.logoutUser { [weak self] error in
            guard let error = error else {
                self?.delegate?.updateViewSignOut(with: true)
                return
            }
            self?.delegate?.updateViewSignOut(with: false)
            self?.delegate?.updateViewSignOutWithError(with: error)
        }
    }
}
