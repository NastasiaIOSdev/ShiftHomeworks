//
//  EmployeeTableViewCell.swift
//  CompanyList
//
//  Created by Анастасия Ларина on 08.06.2022.
//

import UIKit
import SnapKit

final class EmployeeTableViewCell: UITableViewCell {
    static let identifier = "EmployeeTableViewCell"
    
    private enum Constraints {
        static let labelsOffset: CGFloat = 16
        static let labelTopBottomInset = 20
    }
    
// MARK: - Property
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Arial", size: 15)
        return label
    }()
    
     let positionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Arial", size: 15)
        return label
    }()
    
    let experienceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Arial", size: 15)
        return label
    }()
    
     let educationalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Arial", size: 15)
        return label
    }()
    
 // MARK - Init Cell
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK - Dispaly Data

extension EmployeeTableViewCell {
    func displayData(_ viewModel: EmployeeModel) {
        self.nameLabel.text = viewModel.name
        self.ageLabel.text = viewModel.age
        self.positionLabel.text = viewModel.position
        self.experienceLabel.text = viewModel.experience
        self.educationalLabel.text = viewModel.education
    }
}

// MARK: - Setup Cell Layout

private extension EmployeeTableViewCell {
    func setupUI() {
        self.setupLayout()
    }
    
    func setupLayout() {
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.labelTopBottomInset)
            make.leading.equalToSuperview().offset(Constraints.labelsOffset)
        }
        
        self.contentView.addSubview(self.ageLabel)
        self.ageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(Constraints.labelTopBottomInset)
            make.leading.equalToSuperview().offset(Constraints.labelsOffset)
        }
        
        self.contentView.addSubview(self.positionLabel)
        self.positionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ageLabel.snp.bottom).offset(Constraints.labelTopBottomInset)
            make.leading.equalToSuperview().offset(Constraints.labelsOffset)
        }
        
        self.contentView.addSubview(self.experienceLabel)
        self.experienceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.positionLabel.snp.bottom).offset(Constraints.labelTopBottomInset)
            make.leading.equalToSuperview().offset(Constraints.labelsOffset)
        }
        
        self.contentView.addSubview(self.educationalLabel)
        self.educationalLabel.snp.makeConstraints { make in
            make.top.equalTo(self.experienceLabel.snp.bottom).offset(Constraints.labelTopBottomInset)
            make.leading.equalToSuperview().offset(Constraints.labelsOffset)
            make.bottom.equalToSuperview().inset(Constraints.labelTopBottomInset)
        }
    }
}
