//
//  ImageLoader.swift
//  ExploreFoods
//
//  Created by Altan on 11.03.2024.
//

import Foundation
import Alamofire

protocol ImageLoaderService {
    func getImage(url: String, completion: @escaping(Result<Data, AFError>) -> Void)
}

class ImageLoader: ImageLoaderService {
    
    func getImage(url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completion(.failure(AFError.invalidURL(url: url)))
            return
        }
        
        AF.request(imageUrl, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
