//
//  ViewController.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 7.12.2023.
//

import UIKit
import SDWebImage

final class MainCollectionViewController: UICollectionViewController {
    
    let mainViewViewModel = MainViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        
        mainViewViewModel.loadCategories()
        mainViewViewModel.onSuccess = reloadCollectionView()
        mainViewViewModel.onError = showError()
    }
    
    private func reloadCollectionView() -> () -> () {
        return {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width / 2
        
        return CGSize(width: width * 0.8, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension MainCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewViewModel.numberOfItems(in: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
        let categories = mainViewViewModel.cellForItem(at: indexPath)
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.45
        cell.layer.cornerRadius = 8
        cell.categoryImageView.sd_setImage(with: URL(string: categories.strCategoryThumb ?? ""))
        cell.categoryLabel.text = categories.strCategory
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let category = mainViewViewModel.categories?[indexPath.row] else { return }
        
        if let destinationVC = UIStoryboard(name: "CategoryDetailViewController", bundle: nil).instantiateViewController(withIdentifier: "CategoryDetailViewController") as? CategoryDetailViewController {
            destinationVC.detailViewViewModel.selectedCategory = category.strCategory
            destinationVC.detailViewViewModel.indexPath = indexPath.row
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
