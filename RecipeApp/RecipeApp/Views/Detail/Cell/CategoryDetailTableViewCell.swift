//
//  DetailTableViewCell.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 8.12.2023.
//

import UIKit

class CategoryDetailTableViewCell: UITableViewCell {
    static let identifier = "CategoryDetailTableViewCell"
    
    @IBOutlet weak var mealInfoLabel: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
