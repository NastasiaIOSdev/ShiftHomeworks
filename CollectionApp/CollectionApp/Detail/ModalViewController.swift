//
//  ModalViewController.swift
//  CollectionApp
//
//  Created by Анастасия Ларина on 17.05.2022.
//

import UIKit
import SnapKit

class ModalViewController: UIViewController {
    
    private enum Constants {
        static let heightButton = 50
        static let widthButton = 150
        static let cornerRadius: CGFloat = 9
    }
    
    private enum Constraints {
        static let topButtonOffset = 50
    }
    
    private let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupUI()
    }
    @objc
    func buttonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
private extension ModalViewController {
    func setupUI() {
        self.setuoCommonData()
        self.setupLayout()
    }
    
    func setuoCommonData() {
        self.dismissButton.setTitle("Dismiss", for: .normal)
        self.dismissButton.tintColor = .white
        self.dismissButton.backgroundColor = .black
        self.dismissButton.layer.cornerRadius = Constants.cornerRadius
        self.dismissButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupLayout() {
        self.view.addSubview(self.dismissButton)
        self.dismissButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.topButtonOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightButton)
            make.width.equalTo(Constants.widthButton)
        }
    }
}
