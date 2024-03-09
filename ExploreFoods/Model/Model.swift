//
//  Model.swift
//  ExploreFoods
//
//  Created by Altan on 2.03.2024.
//

import Foundation

struct Meals: Codable {
    let meals: [Meal]
}

struct Categories: Codable {
    let categories: [Category]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
