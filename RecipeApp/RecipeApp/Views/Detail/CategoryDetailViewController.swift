//
//  DetailViewController.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import UIKit

final class CategoryDetailViewController: UIViewController {
    
    @IBOutlet weak var mealsTableView: UITableView!
    
    let detailViewViewModel = CategoryDetailViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        setUpTableView()
        
        detailViewViewModel.loadMeals()
        detailViewViewModel.onSuccess = reloadTableView()
        detailViewViewModel.onError = showError()
    }
    
    private func reloadTableView() -> () -> () {
        return {
            DispatchQueue.main.async {
                self.mealsTableView.reloadData()
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
    
    private func setUpNavBar() {
        title = detailViewViewModel.getMealTitle()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setUpTableView() {
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
    }
}

extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewViewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDetailTableViewCell.identifier, for: indexPath) as! CategoryDetailTableViewCell
        
        let meals = detailViewViewModel.cellForItem(at: indexPath)
        
        cell.layer.cornerRadius = 8
        cell.mealImageView.layer.borderColor = UIColor.lightGray.cgColor
        cell.mealImageView.sd_setImage(with: URL(string: meals.strMealThumb ?? ""))
        cell.mealInfoLabel.text = meals.strMeal
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = detailViewViewModel.cellForItem(at: indexPath)
        
        if let destinationVC = UIStoryboard(name: "MealInfoViewController", bundle: nil).instantiateViewController(withIdentifier: "MealInfoViewController") as? MealInfoViewController {
            destinationVC.mealViewViewModel.selectedMealID = meal.idMeal
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
