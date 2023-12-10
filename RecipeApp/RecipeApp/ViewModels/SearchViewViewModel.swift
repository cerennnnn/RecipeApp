//
//  SearchViewViewModel.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import Foundation

final class SearchViewViewModel {
    var onSuccess: (() -> ())?
    var onError: ((_ errorStr: String) -> ())?
    var meals: [Meal]?
    var indexPathMeal: Meal?
    
    func loadCategories(with searchText: String?) {
        var endpoint = "search.php?s="
        
        if let searchText = searchText, !searchText.isEmpty {
            endpoint += searchText
        }
        
        NetworkManager.shared.fetchData(forEndpoint: endpoint, responseType: Meals.self) { result in
            switch result {
            case .success(let success):
                self.meals = success.meals
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    
    func cellForItem(at indexPath: IndexPath) -> Meal {
        guard let meals = meals else { fatalError() }
        
        self.indexPathMeal = meals[indexPath.row]
        
        return meals[indexPath.row]
    }
    
    func numberOfItems(in section: Int) -> Int {
        meals?.count ?? 0
    }
}
