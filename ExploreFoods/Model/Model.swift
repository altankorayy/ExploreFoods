//
//  Model.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import Foundation

struct Meal: Codable {
    let meals: [Meals]
}

struct Meals: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
