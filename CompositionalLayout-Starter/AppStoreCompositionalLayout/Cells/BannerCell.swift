//
//  BannerHeroTextCollectionViewCell.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 30/08/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    static var nib: UINib {
        UINib(nibName: "BannerCell", bundle: nil)
    }
        
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setup(_ item: Item) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        imageView.image = UIImage(named: item.imageName)
    }

}
