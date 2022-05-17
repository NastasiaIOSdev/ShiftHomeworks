//
//  ViewController.swift
//  CollectionApp
//
//  Created by Анастасия Ларина on 13.05.2022.
//

import UIKit

class CollectionViewController: UIViewController {
    
    // MARK: - Properties
    
    private var cells: [Cell] = itemCellArray
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewController.setupLayout())
    
    // MARK: - Life cyclea
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        self.setupCollectionCommonSettings()
        self.setupNavigationItem()
       
    }
}

private extension CollectionViewController {
    
    func setupCollectionCommonSettings() {
        self.collectionView.frame = view.bounds
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupNavigationItem() {
        self.navigationController?.navigationBar.topItem?.title = "Business topics"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

    // MARK - Collection DataSource

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            itemCell.cell = itemCellArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
}

    // MARK - Collection Delegate

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.cell = itemCellArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

// MARK - setupLayout

private extension CollectionViewController {
    static func setupLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)))
        
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)),
            subitem: verticalStackItem,
            count: 2)
        
        let fourItems = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        fourItems.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let fourthGorizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.3)
            ),
            subitem: fourItems,
            count: 4
        )
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.7)
            ),
            subitems: [
                item,
                verticalStackGroup
            ])
        
        horizontalGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let horizontalGroup2 = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.7)
            ),
            subitems: [
                verticalStackGroup,
                item
            ])
        
        horizontalGroup2.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ),
            subitems: [
                horizontalGroup,
                fourthGorizontalGroup,
                horizontalGroup2
            ])
        verticalGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let section = NSCollectionLayoutSection(group: verticalGroup)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
