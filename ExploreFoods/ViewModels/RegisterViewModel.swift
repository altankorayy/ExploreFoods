//
//  RegisterViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 26.02.2024.
//

import Foundation
import Firebase

protocol RegisterViewModelDelegate: AnyObject {
    func registerSuccess(_ state: Bool)
    func showSpinnerView(_ state: Bool)
    func handleError(_ error: String)
}

class RegisterViewModel {
    
    var email: String
    var password: String
    
    private let authManagerService: AuthManagerService
    weak var delegate: RegisterViewModelDelegate?
    
    init(authManagerService: AuthManagerService, email: String, password: String) {
        self.authManagerService = authManagerService
        self.email = email
        self.password = password
    }
    
    public func createUser() {
        delegate?.showSpinnerView(true)
        authManagerService.createUser(email: email, password: password) { [weak self] error in
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
