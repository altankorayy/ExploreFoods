//
//  ViewController.swift
//  ExploreFoods
//
//  Created by Altan on 24.02.2024.
//

import UIKit
import Firebase
import Alamofire

enum Sections: Int {
    case country = 0
    case categories = 1
    case popular = 2
    case specials = 3
}

class HomeVC: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        tableView.register(PopularTableViewCell.self, forCellReuseIdentifier: PopularTableViewCell.identifier)
        tableView.register(SpecialsTableViewCell.self, forCellReuseIdentifier: SpecialsTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    private let viewModel: HomeViewModel
    
    let sectionsTitles = ["Country","Categories", "Popular", "Chef's Specials"]
    let areas = ["🇹🇷 Turkey", "🇨🇦 Canada", "🇧🇷 Brasil", "🇩🇪 Germany", "🇨🇳 China", "🇮🇳 India", "🇩🇰 Denmark", "🇰🇷 Korean"]
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        self.viewModel.getMealsByArea_TR()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        if currentUser.uid.isEmpty {
            configureSheet()
        }
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
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
        
        let favoritesList = UIBarButtonItem(image: SFSymbols.favoriteList, style: .done, target: self, action: nil)
        favoritesList.tintColor = UIColorKit.customBlue
        navigationItem.rightBarButtonItem = favoritesList
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.country.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
            
            cell.configure(with: areas)
            return cell
        case Sections.categories.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
            
            return cell
        case Sections.popular.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.identifier, for: indexPath) as? PopularTableViewCell else { return UITableViewCell() }
            
            return cell
        case Sections.specials.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SpecialsTableViewCell.identifier, for: indexPath) as? SpecialsTableViewCell else { return UITableViewCell() }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Sections.country.rawValue:
            return 120
        case Sections.categories.rawValue:
            return 220
        case Sections.popular.rawValue:
            return 120
        case Sections.specials.rawValue:
            return 120
        default:
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.textColor = .black
    }
}

extension HomeVC: HomeViewModelDelegate {
    func updateView(with model: [Meals]) {
        print(model)
    }
    
    func updateViewWithError(with error: Alamofire.AFError) {
        print(error)
    }
}

