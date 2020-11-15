//
//  ViewController.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 30/08/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import SwiftUI

typealias LayoutSectionItemsTuple = (title: String, layout: SectionLayout, items: [Item])

class ViewController: UIViewController {
    
    let backingStore: [LayoutSectionItemsTuple] = [

    ]
    
    var dataSource: UICollectionViewDiffableDataSource<SectionLayout, Item>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Compositional Layout"
        configureHierarchy()
        setupCellAndSupplementaryRegistrations()
        configureDataSource()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    var bannerCellRegistration: UICollectionView.CellRegistration<BannerCell, Item>!
    var listCellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Item>!
    var columnCellRegistration: UICollectionView.CellRegistration<ColumnCell, Item>!
    var avatarCellRegistration: UICollectionView.CellRegistration<AvatarCell, Item>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    func setupCellAndSupplementaryRegistrations() {
        bannerCellRegistration = .init(cellNib: BannerCell.nib, handler: { (cell, _, item) in
            cell.setup(item)
        })
        
        listCellRegistration = .init(handler: { (cell, indexPath, item) in
            cell.setup(item: item)
        })
        
        columnCellRegistration = .init(cellNib: ColumnCell.nib, handler: { (cell, _, item) in
            cell.setup(item)
        })
        
        avatarCellRegistration = .init(cellNib: AvatarCell.nib, handler: { (cell, indexPath, item) in
            let sectionIdentifier = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            switch sectionIdentifier {
            case .storiesCarousel:
                cell.textLabel.isHidden = true
            default:
                cell.textLabel.isHidden = false
            }
            cell.setup(item: item)
        })
        
        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, _, indexPath) in
            let title = self.backingStore[indexPath.section].title
            header.titleLabel.text = title
        })
        
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }
    
    func createLayout() -> UICollectionViewLayout {
        fatalError("TODO: Implement Compositional Layout")
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionLayout, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            guard let sectionIdentifier = self.dataSource.snapshot().sectionIdentifier(containingItem: item) else {
                return nil
            }
            switch sectionIdentifier {
            case .bannerCarousel:
                return collectionView.dequeueConfiguredReusableCell(using: self.bannerCellRegistration, for: indexPath, item: item)
            case .storiesCarousel, .grid:
                return collectionView.dequeueConfiguredReusableCell(using: self.avatarCellRegistration, for: indexPath, item: item)
            case .list:
                return collectionView.dequeueConfiguredReusableCell(using: self.listCellRegistration, for: indexPath, item: item)
            case .columnCarousel:
                return collectionView.dequeueConfiguredReusableCell(using: self.columnCellRegistration, for: indexPath, item: item)
            }
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayout, Item>()
        backingStore.forEach { section in
            snapshot.appendSections([section.layout])
            snapshot.appendItems(section.items)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: ViewController())
    }
}

struct ViewController_Previews: PreviewProvider {
    
    static var previews: some SwiftUI.View {
        ViewControllerRepresentable()
            .edgesIgnoringSafeArea(.vertical)
//            .colorScheme(.dark)
        //            .environment(\.sizeCategory, ContentSizeCategory.accessibilityExtraExtraExtraLarge)
    }
    
}
