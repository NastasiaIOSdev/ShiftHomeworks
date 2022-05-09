//
//  SoftSkillsViewController.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 05.05.2022.
//

import UIKit

class SoftSkillsViewController: UIViewController {
    
    // MARK: - Constants & Constraints
    
    private enum Constants {
        static let imageWidth = 150
        static let imageHeight = 200
    }
    
    private enum Constraints {
        static let topHeaderOffset = 60
        static let topSkillOffset = 30
        static let topLineOffset = 7
        static let horisontalLeadingOffset = 30
    }
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let skill1Label = UILabel()
    private let skill2Label = UILabel()
    private let skill3Label = UILabel()
    private let skill4Label = UILabel()
    private let hobbyLabel = UILabel()
    private let avatarImage = UIImageView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSoftSkillsData(SoftSkillsModel())
        self.setupSoftSkillsView()
    }
    
    // MARK: - SetupData
    
    func setupSoftSkillsData(_ viewModel: SoftSkillsModel) {
        self.headerLabel.text = viewModel.header
        self.skill1Label.text = viewModel.softSkill1
        self.skill2Label.text = viewModel.softSkill2
        self.skill3Label.text = viewModel.softSkill3
        self.skill4Label.text = viewModel.softSkill4
        self.hobbyLabel.text = viewModel.hobby
        self.avatarImage.image = viewModel.avatar
    }
}

private extension SoftSkillsViewController {
    func setupSoftSkillsView() {
        self.setupBackGroundView()
        self.setupCommonData()
        self.setupLayout()
    }
    
    func setupBackGroundView() {
        self.view.backgroundColor = UIColor(displayP3Red: 241/255, green: 221/255, blue: 201/255, alpha: 1)
    }
    
    // MARK: - SetupCommonData
    
    func setupCommonData() {
        self.headerLabel.numberOfLines = 1
        self.headerLabel.font = AppFonts.bold32.font
        self.headerLabel.textColor = .black
        
        self.skill1Label.numberOfLines = 1
        self.skill1Label.font = AppFonts.light16.font
        self.skill1Label.textColor = .black
        
        self.skill2Label.numberOfLines = 1
        self.skill2Label.font = AppFonts.light16.font
        self.skill2Label.textColor = .black
        
        self.skill3Label.numberOfLines = 1
        self.skill3Label.font = AppFonts.light16.font
        self.skill3Label.textColor = .black
        
        self.skill4Label.numberOfLines = 1
        self.skill4Label.font = AppFonts.light16.font
        self.skill4Label.textColor = .black
        
        self.hobbyLabel.numberOfLines = 0
        self.hobbyLabel.font = AppFonts.light16.font
        self.hobbyLabel.textColor = .black
    }
    
    // MARK: - Layouts
    
    func setupLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.topHeaderOffset)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(self.skill1Label)
        self.skill1Label.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(Constraints.topSkillOffset)
            make.leading.equalToSuperview()
                .offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.skill2Label)
        self.skill2Label.snp.makeConstraints { make in
            make.top.equalTo(self.skill1Label.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.skill3Label)
        self.skill3Label.snp.makeConstraints { make in
            make.top.equalTo(self.skill2Label.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.skill4Label)
        self.skill4Label.snp.makeConstraints { make in
            make.top.equalTo(self.skill3Label.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.hobbyLabel)
        self.hobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.skill4Label.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
            make.trailing.equalTo(self.view.safeAreaInsets)
        }
        
        self.view.addSubview(self.avatarImage)
        self.avatarImage.snp.makeConstraints { make in
            make.top.equalTo(self.hobbyLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.imageHeight)
            make.width.equalTo(Constants.imageWidth)
        }
    }
}
