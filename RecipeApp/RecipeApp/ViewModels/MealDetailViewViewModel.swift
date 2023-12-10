//
//  MealDetailViewViewModel.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import UIKit

final class MealDetailViewViewModel {
    var onSuccess: (() -> ())?
    var onError: ((_ errorStr: String) -> ())?
    var meals: [Meal]?
    var indexPathMeal: Meal?
    var indexPath: Int?
    var selectedMealID: String?
    var selectedMeal: Meal?
    
    func loadMeals() {
        guard let selectedMealID = selectedMealID else { return }
        NetworkManager.shared.fetchData(forEndpoint: "lookup.php?i=\(selectedMealID)", responseType: Meals.self) { [self] result in
            switch result {
            case .success(let success):
                self.meals = success.meals
                guard let meal = meals?.first else { return }
                selectedMeal = meal
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    func getSelectedMealImage() -> String? {
        selectedMeal?.strMealThumb ?? "Unknown"
    }
    
    func getName() -> String? {
        selectedMeal?.strMeal ?? "Unknown"
    }
    
    func getDescription() -> String? {
        selectedMeal?.strInstructions ?? "Unknown"
    }
    
    func getCategory() -> String? {
        selectedMeal?.strCategory ?? "Unknown"
    }
    
    func getYoutubeURL() -> URL? {
        guard let meal = selectedMeal else { fatalError() }
        
        guard let url = URL(string: meal.strYoutube ?? "") else { fatalError()  }
        
        return url
    }
}
