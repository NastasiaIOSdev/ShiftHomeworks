//
//  CollectionViewCell.swift
//  CollectionApp
//
//  Created by Анастасия Ларина on 16.05.2022.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "cell"
    
    private enum Texts {
        static let buttonFontName = "Avenir Next"
    }
    
    var cell: Cell? {
        didSet {
            nameLabel.text = cell?.name ?? ""
            if let image = cell?.image {
                imageView.image = UIImage(named: image)
            }
        }
    }
    
    private let cellView = UIView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupUI()
    }
}

private extension CollectionViewCell {
    func setupUI() {
        setupCommonData()
        setupLayout()
    }
    
    func setupCommonData() {
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        
        self.nameLabel.textAlignment = .center
        self.nameLabel.numberOfLines = 1
        self.nameLabel.font = UIFont(name: Texts.buttonFontName, size: 12)
        self.nameLabel.textColor = .black
        self.nameLabel.backgroundColor = .systemGray5
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.nameLabel.minimumScaleFactor = 0.5
    }
    
    // MARK - setupLayout
    
    func setupLayout() {
        self.addSubview(self.cellView)
        self.cellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.cellView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.cellView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
