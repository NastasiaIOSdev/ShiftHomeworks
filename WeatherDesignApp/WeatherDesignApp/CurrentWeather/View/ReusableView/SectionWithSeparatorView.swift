//
//  SectionWithSeparatorView.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation
import UIKit
import SnapKit

class SectionWithSeparatorView: UIView {
    
    enum Atmosphere { //type
        case wind
        case humidity
        
        var description: String {
            switch self {
            case .wind: return "Wind"
            case .humidity: return "Hum"
            }
        }
        var image: UIImage? {
            switch self {
            case .wind: return UIImage(named: "windy")
            case .humidity: return UIImage(named: "hum")
            }
        }
        
        var unit: String {
            switch self {
            case .wind:
                return " km/h"
            case .humidity:
                return " %"
            }
        }
    }
    
    private enum Constants {
       static let imageViewVerticalOffset = 5
       static let separatorLabel = "|"
    }
    
// MARK: - Properties
       
    let dataLabel = UILabel()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let separatorLabel = UILabel()
    private let unitLabel = UILabel()
 
// MARK: - Init
    
    init(type: Atmosphere) {
        super.init(frame: .zero)
        self.configureView(with: type)
        self.setupLayout()
        self.setupCommonData() 
        self.backgroundColor = .clear
    }
    
    @available(* , unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ value: String) {
        self.dataLabel.text = value
    }
}

// MARK: - Setup Layout

private extension SectionWithSeparatorView {
    func setupLayout() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.imageViewVerticalOffset)
            make.leading.equalToSuperview()
        }
        
        self.addSubview(self.separatorLabel)
        self.separatorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.imageViewVerticalOffset)
            make.leading.equalTo(self.imageView.snp.trailing)
            make.trailing.equalTo(self.separatorLabel.snp.leading)
        }
        
        self.addSubview(self.dataLabel)
        self.dataLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.imageViewVerticalOffset)
            make.leading.equalTo(self.separatorLabel.snp.trailing)
        }
        
        self.addSubview(self.unitLabel)
        self.unitLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.imageViewVerticalOffset)
            make.leading.equalTo(self.dataLabel.snp.trailing)
            make.trailing.equalToSuperview()
        }
    }
}

// MARK: - Setup Common data

private extension SectionWithSeparatorView {
    
    func configureView(with type: Atmosphere) {
        self.imageView.image = type.image
        self.nameLabel.text = type.description
        self.unitLabel.text = type.unit
    }
    
    func setupCommonData() {
        nameLabel.numberOfLines = 1
        nameLabel.font = AppFonts.regular20.font
        nameLabel.textAlignment = .center
        nameLabel.lineBreakMode = .byClipping
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.sizeToFit()
        nameLabel.minimumScaleFactor = 0.3
        nameLabel.textColor = .white
        
        separatorLabel.numberOfLines = 1
        separatorLabel.font = AppFonts.light18.font
        separatorLabel.text = Constants.separatorLabel
        separatorLabel.textAlignment = .center
        separatorLabel.textColor = .white
        
        dataLabel.numberOfLines = 1
        dataLabel.font = AppFonts.regular20.font
        dataLabel.textAlignment = .left
        dataLabel.adjustsFontSizeToFitWidth = true
        dataLabel.textColor = .white
        
        unitLabel.numberOfLines = 1
        unitLabel.font = AppFonts.regular20.font
        unitLabel.textAlignment = .left
        unitLabel.adjustsFontSizeToFitWidth = true
        unitLabel.textColor = .white
    }
    
    
}
