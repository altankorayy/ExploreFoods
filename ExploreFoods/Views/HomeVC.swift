//
//  ViewController.swift
//  ExploreFoods
//
//  Created by Altan on 24.02.2024.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSheet()
    }
    
    private func configureSheet() {
        let vc = WelcomeVC()
        let navVC = UINavigationController(rootViewController: vc)
        
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                context.maximumDetentValue * 0.4
            })]
            sheet.preferredCornerRadius = 30
            sheet.prefersGrabberVisible = true
        }
        
        navVC.isModalInPresentation = true
        navigationController?.present(navVC, animated: true)
    }
    
    private func configureView() {
        title = "Explore Foods"
        view.backgroundColor = .systemBackground
        let favoritesList = UIBarButtonItem(image: SFSymbols.favoriteList, style: .done, target: self, action: nil)
        favoritesList.tintColor = .systemPink
        navigationItem.rightBarButtonItem = favoritesList
    }
}

