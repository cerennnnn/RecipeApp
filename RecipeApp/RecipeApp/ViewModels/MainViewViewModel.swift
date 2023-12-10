//
//  MainViewViewModel.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 7.12.2023.
//

import UIKit

final class MainViewViewModel {
    var onSuccess: (() -> ())?
    var onError: ((_ errorStr: String) -> ())?
    var categories: [Category]?
    var indexPathCategory: Category?
    var indexPath: Int?
    
    func loadCategories() {
        NetworkManager.shared.fetchData(forEndpoint: "categories.php", responseType: Categories.self) { result in
            switch result {
            case .success(let success):
                self.categories = success.categories
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    func cellForItem(at indexPath: IndexPath) -> Category {
        guard let categories = categories else { fatalError() }
        
        self.indexPathCategory = categories[indexPath.row]
        
        return categories[indexPath.row]
    }
    
    func numberOfItems(in section: Int) -> Int {
        categories?.count ?? 0
    }
}
