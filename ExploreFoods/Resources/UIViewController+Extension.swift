//
//  UIViewController+Extension.swift
//  ExploreFoods
//
//  Created by Altan on 26.02.2024.
//

import UIKit

let spinnerView = SpinnerView()

extension UIViewController {
    
    func startSpinnerView() {
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinnerView)
        
        spinnerView.alpha = 0
        
        UIView.animate(withDuration: 0.35) {
            spinnerView.alpha = 0.8
        }
        
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinnerView.widthAnchor.constraint(equalToConstant: 100),
            spinnerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func dismissSpinnerView() {
        DispatchQueue.main.async {
            spinnerView.removeFromSuperview()
        }
    }
    
    func showAlertView(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }
}
