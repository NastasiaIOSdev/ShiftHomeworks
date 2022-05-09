//
//  ViewController.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 05.05.2022.
//

import UIKit
import SnapKit

class AboutMeViewController: UIViewController {

    private let headerLabel: UILabel = {
       let label = UILabel()
        label.font = AppFonts.bold32.font
        label.text = "Обо мне :"
        return label
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 241/255, green: 221/255, blue: 201/255, alpha: 1)
        //navigationItem.title = "About me :"
        self.setupLayout()
    }
    
    private func setupLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
    }
}

