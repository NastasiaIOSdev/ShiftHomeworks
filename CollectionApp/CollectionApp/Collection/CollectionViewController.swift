//
//  ViewController.swift
//  CollectionApp
//
//  Created by Анастасия Ларина on 13.05.2022.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {
    
    private enum Texts {
        static let navigationBarTopItemTitle = "Business topics"
    }
    
    private enum Constants {
        static let itemsPerRow: CGFloat = 2
        static let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

// MARK: - Properties
    
    private var cells: [Cell] = itemCellArray
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
// MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension CollectionViewController {
    func setupUI() {
        self.view.addSubview(collectionView)
        self.setupNavigationItem()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.setupCollectionLayout()
    }
    
    func setupNavigationItem() {
        self.navigationController?.navigationBar.topItem?.title = Texts.navigationBarTopItemTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupCollectionLayout() {
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - Collection DataSource

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell {
            itemCell.cell = itemCellArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
}
    
// MARK: - Collection Delegate

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailAssembly.build()
        detailVC.cell = itemCellArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - CollectionViewFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widtherItem = availableWidth / Constants.itemsPerRow
        
        return CGSize(width: widtherItem, height: widtherItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
}
