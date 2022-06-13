//
//  CompanyTableViewCell.swift
//  CompanyList
//
//  Created by Анастасия Ларина on 08.06.2022.
//

import UIKit
import SnapKit

final class CompanyTableViewCell: UITableViewCell {

    static let identifier = "CompanyTableViewCell"
    
    private enum Constraints {
        static let labelsOffset: CGFloat = 16
        static let labelTopBottomInset = 20
    }
    
// MARK: - Property
    
    var companyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = .brown
        return label
    }()
    
    private let numberOfEmployeeLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.textColor = .brown
        label.font = UIFont(name: "Arial", size: 15)
        label.text = "0"
       return label
    }()

// MARK: - Init Cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Display cell Data

extension CompanyTableViewCell {
    func displayData(_ viewModel: CompanyModel) {
        self.companyLabel.text = viewModel.name
        self.numberOfEmployeeLabel.text = viewModel.numberOfEmployee
    }
}

// MARK: - Setup Layout

private extension CompanyTableViewCell {
    func setupUI() {
        self.setupLayout()
    }
    
    func setupLayout() {
        self.contentView.addSubview(self.companyLabel)
        self.companyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.labelTopBottomInset)
            make.leading.equalToSuperview().offset(Constraints.labelsOffset)
        }
        
        self.contentView.addSubview(self.numberOfEmployeeLabel)
        self.numberOfEmployeeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.labelTopBottomInset)
            make.trailing.equalToSuperview().offset(Constraints.labelsOffset)
        }
    }
}

