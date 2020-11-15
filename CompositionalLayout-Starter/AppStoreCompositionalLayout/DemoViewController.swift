//
//  DemoViewController.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 11/14/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import UIKit

class DemoViewController: UIViewController {
    
    var randomColors: [UIColor] = [
        .red,
        .green,
        .blue,
        .cyan,
        .magenta,
        .orange,
        .purple,
        .systemPink,
        .systemIndigo,
        .yellow
    ]
    
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Compositional Layout"
        configureHierarchy()
        configureDataSource()
    }
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell   , Int>!

    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        cellRegistration = .init(handler: { (cell, _, _) in
            cell.backgroundColor = self.randomColors.randomElement()
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor
        })
    }
    
    func createLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.333), heightDimension: .fractionalHeight(1.0)))
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2)), subitem: item, count: 3)
            
        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: identifier)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        let items = (0...30).map { $0 }
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
}

struct DemoViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: DemoViewController())
    }
    
}

struct DemoViewController_Previews: PreviewProvider {
    
    static var previews: some View {
        DemoViewControllerRepresentable().edgesIgnoringSafeArea(.vertical)
    }
    
}
