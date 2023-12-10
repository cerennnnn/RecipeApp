//
//  SearchTableViewCell.swift
//  RecipeApp
//
//  Created by Ceren Güneş on 9.12.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var searchImgeView: UIImageView!
    @IBOutlet weak var searchDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
