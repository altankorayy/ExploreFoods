//
//  APIEndpoint.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import Foundation

enum APIEndpoint: String {
    case baseUrl = "https://www.themealdb.com"
    case byArea = "/api/json/v1/1/filter.php?a="
    case categories = "/api/json/v1/1/categories.php"
    case desserts = "/api/json/v1/1/filter.php?c=Dessert"
    case searchMeal = "/api/json/v1/1/search.php?s="
}
