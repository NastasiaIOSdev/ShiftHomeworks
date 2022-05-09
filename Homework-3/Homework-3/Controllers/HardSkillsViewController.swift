//
//  HardSkillsViewController.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 05.05.2022.
//

import UIKit
import SnapKit

class HardSkillsViewController: UIViewController {
    
    private enum Constraints {
        static let topHeaderOffset = 60
        static let topSkillOffset = 30
        static let topLineOffset = 7
        static let horisontalLeadingOffset = 30
    }
    
    private let headerLabel = UILabel()
    private let skill1Label = UILabel()
    private let skill2Label = UILabel()
    private let skill3Label = UILabel()
    private let skill4Label = UILabel()
    private let experienceLabel = UILabel()
    private let expectationsLabel = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHardSkillsData(HardSkillsModel())
        self.setupHardSkillsView()
    }
    
    func setupHardSkillsData(_ viewModel: HardSkillsModel) {
        self.headerLabel.text = viewModel.header
        self.skill1Label.text = viewModel.hardSkill1
        self.skill2Label.text = viewModel.hardSkill2
        self.skill3Label.text = viewModel.hardSkill3
        self.skill4Label.text = viewModel.hardSkill4
        self.experienceLabel.text = viewModel.howLongHaveBeenProgramming
        self.expectationsLabel.text = viewModel.whatIexpextFromTheShiftCourses
    }
}

private extension HardSkillsViewController {
    func setupHardSkillsView() {
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
        
        self.skill1Label.numberOfLines = 1
        self.skill1Label.font = AppFonts.light20.font
        self.skill1Label.textColor = .black
        
        self.skill2Label.numberOfLines = 1
        self.skill2Label.font = AppFonts.light20.font
        self.skill2Label.textColor = .black
        
        self.skill3Label.numberOfLines = 1
        self.skill3Label.font = AppFonts.light20.font
        self.skill3Label.textColor = .black
        
        self.skill4Label.numberOfLines = 1
        self.skill4Label.font = AppFonts.light20.font
        self.skill4Label.textColor = .black
        
        self.experienceLabel.numberOfLines = 0
        self.experienceLabel.font = AppFonts.light18.font
        self.experienceLabel.textColor = .black
        
        self.expectationsLabel.numberOfLines = 0
        self.expectationsLabel.font = AppFonts.light18.font
        self.expectationsLabel.textColor = .black
    }
    
    func setupLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.topHeaderOffset)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(self.skill1Label)
        self.skill1Label.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(Constraints.topSkillOffset)
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
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
            make.leading.equalToSuperview().offset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.experienceLabel)
        self.experienceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.skill4Label.snp.bottom).offset(Constraints.topSkillOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.expectationsLabel)
        self.expectationsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.experienceLabel.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
    }
}
