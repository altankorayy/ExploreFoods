//
//  NetworkManager.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import UIKit
import Alamofire

protocol NetworkManagerService {
    func getMealsByArea(with area: String, completion: @escaping(Result<Meals, AFError>) -> Void)
    func getCategories(completion: @escaping(Result<Categories, AFError>) -> Void)
}

class NetworkManager: NetworkManagerService {
    
    func getMealsByArea(with area: String, completion: @escaping(Result<Meals, AFError>) -> Void) {
        let endpoint = APIEndpoint.baseUrl.rawValue + APIEndpoint.byArea.rawValue + "\(area)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL(url: endpoint)))
            return
        }
        
        AF.request(url, method: .get).responseDecodable(of: Meals.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCategories(completion: @escaping(Result<Categories, AFError>) -> Void) {
        let endpoint = APIEndpoint.baseUrl.rawValue + APIEndpoint.categories.rawValue
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(AFError.invalidURL(url: endpoint)))
            return
        }
        
        AF.request(url, method: .get).responseDecodable(of: Categories.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
