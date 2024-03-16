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
    case dessert = 2
}

class HomeVC: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        tableView.register(DessertTableViewCell.self, forCellReuseIdentifier: DessertTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    private let viewModel: HomeViewModel
    
    let sectionsTitles = ["Country","Categories", "Desserts"]
    let areas = ["🇹🇷 Turkish", "🇯🇵 Japanese", "🇬🇧 British", "🇫🇷 French", "🇨🇳 Chinese", "🇮🇳 Indian", "🇮🇹 Italian", "🇷🇺 Russian"]
    
    var areasModel = [Meal]()
    var categoriesModel = [Category]()
    var dessertsModel = [Meal]()
    
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
        
        self.viewModel.getCategories()
        self.viewModel.getDesserts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser == nil {
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
            sheet.preferredCornerRadius = 25
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
        favoritesList.tintColor = UIColorKit.red
        navigationItem.rightBarButtonItem = favoritesList
        
        let logoutButton = UIBarButtonItem(image: SFSymbols.logout, style: .done, target: self, action: #selector(didTapLogoutButton))
        logoutButton.tintColor = UIColorKit.red
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    @objc
    private func didTapLogoutButton() {
        let actionSheet = UIAlertController(title: nil, message: "Do you want to sign out?", preferredStyle: UIAlertController.Style.actionSheet)
        let signOutButton = UIAlertAction(title: "Sign out", style: .destructive) { [weak self] _ in
            
            self?.viewModel.delegate = self
            self?.viewModel.logoutUser()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(signOutButton)
        actionSheet.addAction(cancelButton)
        present(actionSheet, animated: true)
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
            cell.delegate = self
            cell.configure(with: areas)
            return cell
        case Sections.categories.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: categoriesModel)
            return cell
        case Sections.dessert.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DessertTableViewCell.identifier, for: indexPath) as? DessertTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: dessertsModel)
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
            return 130
        case Sections.categories.rawValue:
            return 250
        case Sections.dessert.rawValue:
            return 110
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
    func updateViewSignOut(with state: Bool) {
        if state {
            configureSheet()
        }
    }
    
    func updateViewSignOutWithError(with error: FirebaseAuthError?) {
        guard let error = error else { return }
        showAlertView(title: "Something went wrong", message: error.rawValue)
    }
    
    func updateViewDesserts(with dessert: [Meal]) {
        self.dessertsModel = dessert
        
        self.tableView.reloadData()
    }
    
    func updateViewArea(with area: [Meal]) {
        self.areasModel = area
        
        self.tableView.reloadData()
    }
    
    func updateViewCategories(with categories: [Category]) {
        self.categoriesModel = categories
        
        self.tableView.reloadData()
    }
    
    func updateViewWithError(with error: Alamofire.AFError) {
        showAlertView(title: "Error", message: error.localizedDescription)
    }
}

extension HomeVC: CountryTableViewCellDelegate {
    func didSelectItemAt(with area: String, viewController: UIViewController) {
        viewController.title = "\(area) Special Meals"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeVC: CategoriesTableViewCellDelegate {
    func didSelectItemAt(with category: Category, viewController: UIViewController) {
        viewController.title = category.strCategory
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeVC: DessertTableViewCellDelegate {
    func didSelectItemAt(with meal: Meal, viewController: UIViewController) {
        viewController.title = meal.strMeal
        navigationController?.pushViewController(viewController, animated: true)
    }
}

