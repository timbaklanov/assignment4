//
//  ReciepieTableViewCell.swift
//  finalproject
//
//  Created by Тимур Бакланов on 11.12.2021.
//

import UIKit

class ReciepieTableViewCell: UITableViewCell {

    @IBOutlet weak var recepieImg: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
