//
//  RegisterVC.swift
//  ExploreFoods
//
//  Created by Altan on 24.02.2024.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign Up"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Name and surname"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 17
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.keyboardType = .emailAddress
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Email"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 17
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.keyboardType = .emailAddress
        textField.adjustsFontSizeToFitWidth = true
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Password"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 17
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.adjustsFontSizeToFitWidth = true
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Complete", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = UIColorKit.red
        return button
    }()
    
    var viewModel: RegisterViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, usernameTextField, emailTextField, passwordTextField, completeButton)
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        completeButton.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapCompleteButton() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlertView(title: "Something went wrong", message: "Please fill the username and password.")
            return
        }
        
        let authManagerService: AuthManagerService = AuthManager()
        viewModel = RegisterViewModel(authManagerService: authManagerService, email: email, password: password)
        viewModel?.delegate = self
        viewModel?.createUser()
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            completeButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            completeButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}

extension RegisterVC: RegisterViewModelDelegate {
    func registerSuccess(_ state: Bool) {
        if state {
            dismiss(animated: true)
            NotificationCenter.default.post(name: .registerSuccess, object: nil)
        }
    }
    
    func handleError(_ error: String) {
        showAlertView(title: "Something went wrong", message: error)
    }
    
    func showSpinnerView(_ state: Bool) {
        if state {
            startSpinnerView()
        } else {
            dismissSpinnerView()
        }
    }
}
