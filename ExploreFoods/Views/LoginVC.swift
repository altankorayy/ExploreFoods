//
//  LoginVC.swift
//  ExploreFoods
//
//  Created by Altan on 24.02.2024.
//

import UIKit

class LoginVC: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign In"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
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
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Complete", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = UIColor.systemPink
        return button
    }()
    
    var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, emailTextField, passwordTextField, forgotPasswordButton, completeButton)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
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
        viewModel = LoginViewModel(authManagerService: authManagerService, email: email, password: password)
        viewModel?.delegate = self
        viewModel?.loginUser()
    }
    
    @objc
    private func didTapForgotPasswordButton() {
        print("forgot password")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 25),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 150),
            
            completeButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 50),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            completeButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginVC: LoginViewModelDelegate {
    func registerSuccess(_ state: Bool) {
        if state {
            dismiss(animated: true)
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

