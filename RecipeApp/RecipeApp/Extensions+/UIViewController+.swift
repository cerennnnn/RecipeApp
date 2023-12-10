//
//  AlertExtension.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 10.12.2023.
//

import UIKit

extension UIViewController {
    func displayErrorAlert(message: String) {
        let vc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                     
        present(vc, animated: true)
    }
}
