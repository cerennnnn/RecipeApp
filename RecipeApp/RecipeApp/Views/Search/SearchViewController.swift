//
//  SearchViewController.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import UIKit

final class SearchTableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    let searchViewViewModel = SearchViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        setUpTableView()
        
        searchViewViewModel.loadCategories(with: "")
        searchViewViewModel.onSuccess = reloadTableView()
        searchViewViewModel.onError = showError()
    }
    
    private func reloadTableView() -> () -> () {
        return {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    private func showError() -> (_ errorStr: String) -> () {
        return { [weak self] errorStr in
            DispatchQueue.main.async {
                self?.displayErrorAlert(message: errorStr)
            }
        }
    } 
    
    private func setUpTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func setUpNavBar() {
        title = "Search"
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewViewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let searchMeal = searchViewViewModel.cellForItem(at: indexPath)
        
        cell.searchImgeView.sd_setImage(with: URL(string: searchMeal.strMealThumb ?? ""))
        cell.searchDescriptionLabel.text = searchMeal.strInstructions
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let searchedMeal = searchViewViewModel.meals?[indexPath.row] else { return }
        
        if let destinationVC = UIStoryboard(name: "MealInfoViewController", bundle: nil).instantiateViewController(withIdentifier: "MealInfoViewController") as? MealInfoViewController {
            destinationVC.mealViewViewModel.selectedMealID = searchedMeal.idMeal
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewViewModel.loadCategories(with: searchText)
    }
}
