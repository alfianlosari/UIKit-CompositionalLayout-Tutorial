//
//  GridItemCollectionViewCell.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 11/11/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    static var nib: UINib {
        UINib(nibName: "AvatarCell", bundle: nil)
    }
    
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    func setup(item: Item) {
        textLabel.text = item.title
        imageView.image = UIImage(named: item.imageName)
    }
}

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
}
