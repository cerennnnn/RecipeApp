//
//  DetailViewViewModel.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import UIKit

final class CategoryDetailViewViewModel {
    var onSuccess: (() -> ())?
    var onError: ((_ errorStr: String) -> ())?
    var meals: [CategoryMeal]?
    var indexPathMeal: CategoryMeal?
    var indexPath: Int?
    var selectedCategory: String?
    
    func loadMeals() {
        guard let selectedCategory = selectedCategory else { return }
        NetworkManager.shared.fetchData(forEndpoint: "filter.php?c=\(selectedCategory)", responseType: CategoryMeals.self) { result in
            switch result {
            case .success(let success):
                self.meals = success.meals
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    func cellForItem(at indexPath: IndexPath) -> CategoryMeal {
        guard let meals = meals else { fatalError() }
        
        self.indexPathMeal = meals[indexPath.row]
        
        return meals[indexPath.row]
    }
    
    func numberOfItems(in section: Int) -> Int {
        meals?.count ?? 0
    }

    func getMealTitle() -> String {
        selectedCategory ?? ""
    }
}
