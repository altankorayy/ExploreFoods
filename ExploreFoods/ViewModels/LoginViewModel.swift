//
//  LoginViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 28.02.2024.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func registerSuccess(_ state: Bool)
    func showSpinnerView(_ state: Bool)
    func handleError(_ error: String)
}

class LoginViewModel {
    
    var email: String
    var password: String
    
    weak var delegate: LoginViewModelDelegate?
    
    private let authManagerService: AuthManagerService
    
    init(authManagerService: AuthManagerService, email: String, password: String) {
        self.authManagerService = authManagerService
        self.email = email
        self.password = password
    }
    
    public func loginUser() {
        delegate?.showSpinnerView(true)
        authManagerService.loginUser(email: email, password: password) { [weak self] error in
            guard let error = error else {
                self?.delegate?.showSpinnerView(false)
                self?.delegate?.registerSuccess(true)
                return
            }
            self?.delegate?.showSpinnerView(false)
            self?.delegate?.handleError(error.rawValue)
            self?.delegate?.registerSuccess(false)
        }
    }
}
