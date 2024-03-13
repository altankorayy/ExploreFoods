//
//  CountryDetailVC.swift
//  ExploreFoods
//
//  Created by Altan on 12.03.2024.
//

import UIKit
import Alamofire

class CountryDetailVC: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryDetailTableViewCell.self, forCellReuseIdentifier: CountryDetailTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let viewModel: CountryDetailViewModel
    var countryFoodModel = [Meal]()
    
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
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    

}

extension CountryDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryFoodModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryDetailTableViewCell.identifier, for: indexPath) as? CountryDetailTableViewCell else { return UITableViewCell() }
        cell.configure(model: countryFoodModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CountryDetailVC: CountryDetailViewModelDelegate {
    func updateView(model: [Meal]) {
        self.countryFoodModel = model
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateViewWithError(error: Alamofire.AFError) {
        showAlertView(title: "Error", message: error.localizedDescription)
    }
}
