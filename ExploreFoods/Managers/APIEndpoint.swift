//
//  APIEndpoint.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import Foundation

enum APIEndpoint: String {
    case baseUrl = "https://www.themealdb.com/api/json"
    case byArea = "/v1/1/filter.php?a="
    case categories = "/v1/1/categories.php"
}
