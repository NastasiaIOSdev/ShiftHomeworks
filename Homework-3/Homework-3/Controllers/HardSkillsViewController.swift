//
//  HardSkillsViewController.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 05.05.2022.
//

import UIKit
import SnapKit

class HardSkillsViewController: UIViewController {
    
    // MARK: - Constants & Constraints
    
    private enum Constraints {
        static let topHeaderOffset = 60
        static let topSkillOffset = 30
        static let topLineOffset = 7
        static let horisontalLeadingOffset = 30
        static let bottomExpectationsLabelOffset = 7
    }
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let skill1Label = UILabel()
    private let skill2Label = UILabel()
    private let skill3Label = UILabel()
    private let skill4Label = UILabel()
    private let experienceLabel = UILabel()
    private let expectationsLabel = UILabel()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHardSkillsData(HardSkillsModel())
        self.setupHardSkillsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.animateUIAllSkillsLabel()
    }
    
    // MARK: - SetupData
    
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
        self.setupBackGroundView()
        self.setupCommonData()
        self.setupLayout()
        self.animateUIAllSkillsLabel()
    }
    func setupBackGroundView() {
        self.view.backgroundColor = UIColor(displayP3Red: 241/255, green: 221/255, blue: 201/255, alpha: 1)
    }
    
    // MARK: - SetupCommonData
    
    func setupCommonData() {
        self.headerLabel.numberOfLines = 1
        self.headerLabel.font = AppFonts.bold32.font
        self.headerLabel.textAlignment = .center
        self.experienceLabel.adjustsFontSizeToFitWidth = true
        self.headerLabel.textColor = .black
        
        self.skill1Label.numberOfLines = 1
        self.skill1Label.font = AppFonts.light16.font
        self.skill1Label.textAlignment = .left
        self.experienceLabel.adjustsFontSizeToFitWidth = true
        self.skill1Label.textColor = .black
        
        self.skill2Label.numberOfLines = 1
        self.skill2Label.font = AppFonts.light16.font
        self.skill2Label.textAlignment = .left
        self.experienceLabel.adjustsFontSizeToFitWidth = true
        self.skill2Label.textColor = .black
        
        self.skill3Label.numberOfLines = 1
        self.skill3Label.font = AppFonts.light16.font
        self.skill3Label.textAlignment = .left
        self.experienceLabel.adjustsFontSizeToFitWidth = true
        self.skill3Label.textColor = .black
        
        self.skill4Label.numberOfLines = 1
        self.skill4Label.font = AppFonts.light16.font
        self.skill4Label.textAlignment = .left
        self.experienceLabel.adjustsFontSizeToFitWidth = true
        self.skill4Label.textColor = .black
        
        self.experienceLabel.numberOfLines = 0
        self.experienceLabel.adjustsFontSizeToFitWidth = true
        self.experienceLabel.textAlignment = .natural
        self.experienceLabel.font = AppFonts.light16.font
        self.experienceLabel.textColor = .black
        
        self.expectationsLabel.numberOfLines = 0
        self.expectationsLabel.font = AppFonts.light16.font
        self.expectationsLabel.textAlignment = .natural
        self.expectationsLabel.adjustsFontSizeToFitWidth = true
        self.expectationsLabel.textColor = .black
    }
    
    // MARK: - Layouts
    
    func setupLayout() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.topHeaderOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(self.skill1Label)
        self.skill1Label.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(Constraints.topSkillOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.skill2Label)
        self.skill2Label.snp.makeConstraints { make in
            make.top.equalTo(self.skill1Label.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.skill3Label)
        self.skill3Label.snp.makeConstraints { make in
            make.top.equalTo(self.skill2Label.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
        }
        
        self.view.addSubview(self.skill4Label)
        self.skill4Label.snp.makeConstraints { make in
            make.top.equalTo(self.skill3Label.snp.bottom).offset(Constraints.topLineOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalLeadingOffset)
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
            make.bottom.equalTo(self.expectationsLabel.snp.bottom).offset(Constraints.bottomExpectationsLabelOffset)
        }
    }
    
    // MARK: - Animation
    
    func animateUIAllSkillsLabel() {
        let offset = view.bounds.width
        self.skill1Label.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.skill2Label.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.skill3Label.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.skill4Label.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.experienceLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        self.expectationsLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut) {
            self.skill1Label.transform = .identity
            self.skill2Label.transform = .identity
            self.skill3Label.transform = .identity
            self.skill4Label.transform = .identity
            self.experienceLabel.transform = .identity
            self.expectationsLabel.transform = .identity
        }
    }
}
