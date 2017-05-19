//
//  RecipeTableCell.swift
//  Omelet
//
//  Created by Administrator on 27.03.17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation
import UIKit

class RecipeTableCell: UITableViewCell {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeDescription: UITextView!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func prepareForReuse() {
            super.prepareForReuse()
        recipeImage.image = nil
    }
}