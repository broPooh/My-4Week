//
//  MainCollectionViewCell.swift
//  My 4Week
//
//  Created by bro on 2022/05/05.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
