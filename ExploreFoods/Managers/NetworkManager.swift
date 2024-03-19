//
//  NetworkManager.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import UIKit
import Alamofire

protocol NetworkManagerService {
    func getData<T: Codable>(with endpoint: String, responseType: T.Type, completion: @escaping(Result<T, AFError>) -> Void)
}

class NetworkManager: NetworkManagerService {
    
    func getData<T: Codable>(with endpoint: String, responseType: T.Type, completion: @escaping(Result<T, AFError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL(url: endpoint)))
            return
        }
        
        AF.request(url, method: .get).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
