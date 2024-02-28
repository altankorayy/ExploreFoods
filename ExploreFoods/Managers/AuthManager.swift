//
//  AuthManager.swift
//  ExploreFoods
//
//  Created by Altan on 28.02.2024.
//

import UIKit
import Firebase

protocol AuthManagerService {
    func createUser(email: String, password: String, completion: @escaping (FirebaseAuthError?) -> Void)
    func loginUser(email: String, password: String, completion: @escaping (FirebaseAuthError?) -> Void)
}

enum FirebaseAuthError: String, Error {
    case failedToCreateUser = "Failed to create an account. Please try again."
    case failedToLoginUser = "Failed to sign in. Please check your email or password."
}

class AuthManager: AuthManagerService {
    
    let auth = Auth.auth()
        
    func createUser(email: String, password: String, completion: @escaping (FirebaseAuthError?) -> Void) {
        auth.createUser(withEmail: email, password: password) { _, error in
            guard error == nil else {
                completion(.failedToCreateUser)
                return
            }
            completion(nil)
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (FirebaseAuthError?) -> Void) {
        auth.signIn(withEmail: email, password: password) { _, error in
            guard error == nil else {
                completion(.failedToLoginUser)
                return
            }
            completion(nil)
        }
    }
}
