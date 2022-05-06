//
//  DefaultTableViewCell.swift
//  My 4Week
//
//  Created by bro on 2022/05/05.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! 
     
    
    static let identifier = "DefaultTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
