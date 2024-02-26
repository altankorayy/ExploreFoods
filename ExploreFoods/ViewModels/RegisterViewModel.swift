//
//  RegisterViewModel.swift
//  ExploreFoods
//
//  Created by Altan on 26.02.2024.
//

import Foundation
import Firebase

protocol SpinnerViewDelegate: AnyObject {
    func showSpinnerView(_ bool: Bool)
}

enum FirebaseAuthError: String, Error {
    case failedToCreateUser = "Failed to create an account. Please try again." 
}

class RegisterViewModel {
    
    var email: String
    var password: String
    
    weak var delegate: SpinnerViewDelegate?
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    public func createUser(completion: @escaping (FirebaseAuthError?) -> Void) {
        delegate?.showSpinnerView(true)
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            guard error == nil else {
                completion(.failedToCreateUser)
                self?.delegate?.showSpinnerView(false)
                return
            }
            completion(nil)
            self?.delegate?.showSpinnerView(false)
        }
    }
}
