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
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strMealThumb: String
    let strInstructions: String?
    let strYoutube: String?
    let strArea: String?
}

struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
