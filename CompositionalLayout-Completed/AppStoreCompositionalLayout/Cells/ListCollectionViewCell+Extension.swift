//
//  ListCollectionViewCell+Extension.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 11/11/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import UIKit

extension UICollectionViewListCell {
    
    func setup(item: Item) {
        var content = defaultContentConfiguration()
        content.text = item.title
        content.image = UIImage(named: item.imageName)
        content.imageProperties.maximumSize = .init(width: 60, height: 60)
        content.imageProperties.cornerRadius = 30
        contentConfiguration = content
    }
}
