//
//  MealVideoViewController.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import UIKit
import WebKit

class MealVideoViewController: UIViewController {
    
    @IBOutlet weak var mealWebView: WKWebView!
    
    var urlString: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = urlString else { return }

        mealWebView.load(URLRequest(url: url))
    }
    
}
