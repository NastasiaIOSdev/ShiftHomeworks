//
//  ViewController.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 05.05.2022.
//

import UIKit
import SnapKit

class AboutMeViewController: UIViewController {
    
    // MARK: - Constants & Constraints
    
    private enum Constants {
        static let imageWidth = 150
        static let imageHeight = 200
    }
    
    private enum Constraints {
        static let topHeaderOffset = 60
        static let topAvatarOffset = 40
        static let topNameOffset = 10
        static let topLineOffset = 7
        static let horisontalLeadingOffset = 30
        static let bottomCityLabelOffset = 7
    }
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let avatarImage = UIImageView()
    private let nameLabel = UILabel()
    private let surnameLabel = UILabel()
    private let ageLabel = UILabel()
    private let educationLabel = UILabel()
    private let cityLabel = UILabel()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAboutMeData(AboutMeModel())
        self.setupAboutMeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupAnimationUI()
    }
    
    // MARK: - SetupData
    
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
        self.setupBackGroundView()
        self.setupCommonData()
        self.setupLayout()
        self.setupAnimationUI()
    }
    
    func setupBackGroundView() {
        self.view.backgroundColor = UIColor(displayP3Red: 241/255, green: 221/255, blue: 201/255, alpha: 1)
    }
    
    // MARK: - SetupCommonData
    
    func setupCommonData() {
        self.headerLabel.numberOfLines = 1
        self.headerLabel.font = AppFonts.bold32.font
        self.headerLabel.textAlignment = .center
        self.headerLabel.textColor = .black
        
        self.nameLabel.numberOfLines = 1
        self.nameLabel.font = AppFonts.light16.font
        self.nameLabel.textAlignment = .left
        self.nameLabel.textColor = .black
        
        self.surnameLabel.numberOfLines = 1
        self.surnameLabel.font = AppFonts.light16.font
        self.surnameLabel.textAlignment = .left
        self.surnameLabel.textColor = .black
        
        self.ageLabel.numberOfLines = 1
        self.ageLabel.font = AppFonts.light16.font
        self.ageLabel.textAlignment = .left
        self.ageLabel.textColor = .black
        
        self.educationLabel.numberOfLines = 0
        self.educationLabel.font = AppFonts.light16.font
        self.educationLabel.textAlignment = .left
        self.educationLabel.textColor = .black
        
        self.cityLabel.numberOfLines = 1
        self.cityLabel.font = AppFonts.light16.font
        self.cityLabel.textAlignment = .left
        self.cityLabel.textColor = .black
    }
    
    // MARK: - Layouts
    
    func setupLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.topHeaderOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
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
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(surnameLabel)
        self.surnameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(ageLabel)
        self.ageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.surnameLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(educationLabel)
        self.educationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ageLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(cityLabel)
        self.cityLabel.snp.makeConstraints { make in
            make.top.equalTo(self.educationLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
            make.bottom.equalTo(self.cityLabel.snp.bottom).offset(Constraints.bottomCityLabelOffset)
        }
    }
    
    // MARK: - Animation
    
    func setupAnimationUI() {
        self.animateUIAvatarImage()
        self.animateUIAllSkillsLabels()
    }
    
    func animateUIAvatarImage() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = .backwards
        
        self.avatarImage.layer.add(animation, forKey: nil)
    }
    
    func animateUIAllSkillsLabels() {
        let offset = view.bounds.width
        self.nameLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.surnameLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.ageLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.educationLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.cityLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut) {
            self.nameLabel.transform = .identity
            self.surnameLabel.transform = .identity
            self.ageLabel.transform = .identity
            self.educationLabel.transform = .identity
            self.cityLabel.transform = .identity
        }
    }
}
