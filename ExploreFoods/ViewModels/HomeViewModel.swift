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
    func updateViewSignOut(with state: Bool)
    func updateViewSignOutWithError(with error: FirebaseAuthError?)
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
