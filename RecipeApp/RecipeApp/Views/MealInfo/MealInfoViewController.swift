//
//  MealInfoViewController.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import UIKit
import SDWebImage

final class MealInfoViewController: UIViewController {
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    @IBOutlet weak var mealDescriptionLabel: UILabel!
    
    let mealViewViewModel = MealDetailViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealViewViewModel.loadMeals()
        mealViewViewModel.onSuccess = loadLabels()
        mealViewViewModel.onError = showError()
    }
    
    private func loadLabels() -> () -> () {
        return { [weak self] in
            DispatchQueue.main.async {
                self?.mealImageView.sd_setImage(with: URL(string: self?.mealViewViewModel.getSelectedMealImage() ?? ""))
                self?.mealNameLabel.text = self?.mealViewViewModel.getName()
                self?.mealDescriptionLabel.text = self?.mealViewViewModel.getDescription()
                self?.mealCategoryLabel.text = self?.mealViewViewModel.getCategory()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MealVideoViewController" {
            if let destinationVC = segue.destination as? MealVideoViewController {
                if let urlString = mealViewViewModel.getYoutubeURL() {
                    destinationVC.urlString = urlString
                }
            }
        }
    }
}
