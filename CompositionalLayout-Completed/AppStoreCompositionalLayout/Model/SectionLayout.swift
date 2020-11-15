//
//  LayoutSection.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 11/11/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import UIKit

enum SectionLayout: Hashable {
    case storiesCarousel
    case bannerCarousel
    case columnCarousel
    case list
    case grid
}

extension SectionLayout {
    
    func layoutSection(with layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch self {
        
        case .storiesCarousel:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(70), heightDimension: .estimated(1)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = CGFloat(16)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
            section.orthogonalScrollingBehavior = .continuous
            section.supplementariesFollowContentInsets = false
            section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
            return section
            
        case .bannerCarousel:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .estimated(1)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
            section.supplementariesFollowContentInsets = false
            section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
            return section
            
        case .columnCarousel:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
            
            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),heightDimension: .estimated(1)), subitems: Array(repeating: group, count: 3))
            containerGroup.interItemSpacing = .fixed(16)
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
            section.supplementariesFollowContentInsets = false
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
            return section
            
        case .list:
            var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
            listConfiguration.showsSeparators = true
            listConfiguration.headerMode = .supplementary
            let list = NSCollectionLayoutSection.list(using: listConfiguration, layoutEnvironment: layoutEnvironment)
            return list
        
            
        case .grid:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
            
            let noOfColumns = layoutEnvironment.traitCollection.horizontalSizeClass == .compact ? 4 : 8
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .estimated(1)), subitem: item, count: noOfColumns)
            group.interItemSpacing = .fixed(16)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
            section.supplementariesFollowContentInsets = false
            section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
            return section
        }
            
  
    }
    
    fileprivate func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
    }
    
    fileprivate func supplementaryFooterSeparatorItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
    }
    
}
