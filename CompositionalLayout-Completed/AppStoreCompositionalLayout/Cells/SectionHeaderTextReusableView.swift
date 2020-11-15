//
//  SectionHeaderTextReusableView.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 30/08/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

class SectionHeaderTextReusableView: UICollectionReusableView {
    
    static var nib: UINib {
        UINib(nibName: "SectionHeaderTextReusableView", bundle: nil)
    }
        
    @IBOutlet weak var titleLabel: UILabel!
}
