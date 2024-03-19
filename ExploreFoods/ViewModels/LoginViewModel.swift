//
//  LoginViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 28.02.2024.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func registerSuccess(_ state: Bool)
    func showLoadingView(_ state: Bool)
    func registerFailure(_ error: String)
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    private let authManagerService: AuthManagerService
    
    var email: String?
    var password: String?

    init(authManagerService: AuthManagerService, email: String?, password: String?) {
        self.authManagerService = authManagerService
        self.email = email
        self.password = password
    }
    
    public func loginUser() {
        guard let email = email, let password = password else { return }
        
        delegate?.showLoadingView(true)
        authManagerService.loginUser(email: email, password: password) { [weak self] error in
            guard let error = error else {
                self?.delegate?.showLoadingView(false)
                self?.delegate?.registerSuccess(true)
                return
            }
            self?.delegate?.showLoadingView(false)
            self?.delegate?.registerFailure(error.rawValue)
            self?.delegate?.registerSuccess(false)
        }
    }
}
