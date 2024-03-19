//
//  RegisterVC.swift
//  ExploreFoods
//
//  Created by Altan on 24.02.2024.
//

import UIKit

class WelcomeVC: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explore meals from all around the world."
        label.font = .systemFont(ofSize: 26, weight: .heavy)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColorKit.red.cgColor
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.backgroundColor = UIColorKit.red
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAuthNotification), name: .registerSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAuthNotification), name: .loginSuccess, object: nil)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, loginButton, registerButton)
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    @objc
    private func handleAuthNotification() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapRegisterButton() {
        let authManagerService: AuthManagerService = AuthManager()
        let viewModel = RegisterViewModel(authManagerService: authManagerService, email: nil, password: nil)
        let registerVC = RegisterVC(viewModel: viewModel)
        navigationController?.present(registerVC, animated: true)
    }
    
    @objc
    private func didTapLoginButton() {
        let authManagerService: AuthManagerService = AuthManager()
        let viewModel = LoginViewModel(authManagerService: authManagerService, email: nil, password: nil)
        let loginVC = LoginVC(viewModel: viewModel)
        navigationController?.present(loginVC, animated: true)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
