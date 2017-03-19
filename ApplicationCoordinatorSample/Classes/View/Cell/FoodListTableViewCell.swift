//
//  FoodListTableViewCell.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import UIKit

class FoodListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.foodImageView.clipsToBounds = true
        self.foodImageView.contentMode = .scaleAspectFill
        
        self.nameLabel.numberOfLines = 1
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14)
    }
}
