//
//  ViewController.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 05.05.2022.
//

import UIKit
import SnapKit

class AboutMeViewController: UIViewController {

    private enum Constants {
        static let imageWidth = 150
        static let imageHeight = 200
    }
    
    private enum Constraints {
        static let topHeaderOffset = 60
        static let topAvatarOffset = 40
        static let topNameOffset = 30
        static let topLineOffset = 7
        static let horisontalLeadingOffset = 30
    }
    
    private let headerLabel = UILabel()
    private let avatarImage = UIImageView()
    private let nameLabel = UILabel()
    private let surnameLabel = UILabel()
    private let ageLabel = UILabel()
    private let educationLabel = UILabel()
    private let cityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAboutMeData(AboutMeModel())
        self.setupAboutMeView()
    }
  
    func setupAboutMeData(_ viewModel: AboutMeModel) {
        self.headerLabel.text = viewModel.header
        self.avatarImage.image = viewModel.avatar
        self.nameLabel.text = viewModel.name
        self.surnameLabel.text = viewModel.surname
        self.ageLabel.text = viewModel.age
        self.educationLabel.text = viewModel.education
        self.cityLabel.text = viewModel.city
    }
}

private extension AboutMeViewController {
    func setupAboutMeView() {
        setupBackGroundView()
        setupCommonData()
        setupLayout()
    }
    
    func setupBackGroundView() {
        self.view.backgroundColor = UIColor(displayP3Red: 241/255, green: 221/255, blue: 201/255, alpha: 1)
    }
    
    func setupCommonData() {
        self.headerLabel.numberOfLines = 1
        self.headerLabel.font = AppFonts.bold32.font
        self.headerLabel.textColor = .black
        
        self.nameLabel.numberOfLines = 1
        self.nameLabel.font = AppFonts.light20.font
        self.nameLabel.textColor = .black
        
        self.surnameLabel.numberOfLines = 1
        self.surnameLabel.font = AppFonts.light20.font
        self.surnameLabel.textColor = .black
        
        self.ageLabel.numberOfLines = 1
        self.ageLabel.font = AppFonts.light20.font
        self.ageLabel.textColor = .black
        
        self.educationLabel.numberOfLines = 1
        self.educationLabel.font = AppFonts.light20.font
        self.educationLabel.textColor = .black
        
        self.cityLabel.numberOfLines = 1
        self.cityLabel.font = AppFonts.light20.font
        self.cityLabel.textColor = .black
    }
    
       func setupLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.topHeaderOffset)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(self.avatarImage)
        self.avatarImage.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel).offset(Constraints.topAvatarOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.imageHeight)
            make.width.equalTo(Constants.imageWidth)
        }
        
        self.view.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.avatarImage.snp.bottom).offset(Constraints.topNameOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(surnameLabel)
        self.surnameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(ageLabel)
        self.ageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.surnameLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(educationLabel)
        self.educationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ageLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(cityLabel)
        self.cityLabel.snp.makeConstraints { make in
            make.top.equalTo(self.educationLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
    }
}
