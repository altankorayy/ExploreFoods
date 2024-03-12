//
//  CountryDetailVC.swift
//  ExploreFoods
//
//  Created by Altan on 12.03.2024.
//

import UIKit
import Alamofire

class CountryDetailVC: UIViewController {
    
    private let viewModel: CountryDetailViewModel
    
    init(viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        viewModel.getMealsByArea()
    }
    

    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    

}

extension CountryDetailVC: CountryDetailViewModelDelegate {
    func updateView(model: [Meal]) {
        print(model)
    }
    
    func updateViewWithError(error: Alamofire.AFError) {
        showAlertView(title: "Error", message: error.localizedDescription)
    }
}
