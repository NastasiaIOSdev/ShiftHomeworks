//
//  DetailViewController.swift
//  CollectionApp
//
//  Created by Анастасия Ларина on 17.05.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var cell: Cell?
    
    private enum Constants {
        static let heightButton = 50
        static let widthButton = 150
        static let cornerRadius: CGFloat = 9
    }
    
    private enum Constrints {
        static let horizontalLblImageInset = 30
        static let topImageOffset = 50
        static let topButtonOffset = 30
    }
    
    private var nameLabel = UILabel()
    private var imageView = UIImageView()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.setupUI()
        self.setupCellData(Cell())
    }
    
    func setupCellData(_ viewModel: Cell) {
        self.nameLabel.text = cell?.name
        if let image = cell?.image {
            self.imageView.image = UIImage(named: image)
        }
    }
    
    @objc
    func buttonTapped(_sender: Any) {
        let vc = ModalViewController(nibName: nil, bundle: nil)
        self.present(vc, animated: true)
    }
}

private extension DetailViewController {
    func setupUI() {
        setupCommonData()
        setupLayout()
    }
    
    func setupCommonData() {
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.cornerRadius = Constants.cornerRadius
        
        self.nameLabel.textAlignment = .left
        self.nameLabel.numberOfLines = 1
        self.nameLabel.font = UIFont(name: "Avenir Next", size: 20)
        self.nameLabel.textColor = .black
        self.nameLabel.adjustsFontSizeToFitWidth = true
        
        self.button.setTitle("Detail", for: .normal)
        self.button.tintColor = .white
        self.button.backgroundColor = .black
        self.button.layer.cornerRadius = Constants.cornerRadius
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupLayout() {
        self.view.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-100)
        }
        
        self.view.addSubview(self.button)
        self.button.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(Constrints.topButtonOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}
