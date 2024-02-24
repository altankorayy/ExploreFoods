//
//  RegisterVC.swift
//  ExploreFoods
//
//  Created by Altan on 24.02.2024.
//

import UIKit

class RegisterVC: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explore dishes from all around the world."
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
        button.setTitleColor(.systemPink, for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemPink.cgColor
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
        button.backgroundColor = UIColor.systemPink
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, loginButton, registerButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 300),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
