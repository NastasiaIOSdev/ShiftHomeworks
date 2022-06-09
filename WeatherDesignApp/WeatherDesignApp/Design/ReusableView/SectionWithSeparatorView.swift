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
    }
    
    // MARK: - Properties
    
    private enum Constants {
       static let imageViewVerticalOffset = 5
    }
    
    private let imageView = UIImageView()
    
    private let nameLabel = LabelBuilder()
        .setupNumberOfLines(1)
        .setupFont(AppFonts.regular20.font)
        .setupTextAligment(.center)
        .setupLineBreakMode(.byClipping)
        .setupadjustsFontSizeToFitWidth(true)
        .setupsizeToFit()
        .setupMinimumScaleFactor(0.3)
        .setupTextColor(.white)
        .build()
    
    private let separatorLabel = LabelBuilder()
        .setupNumberOfLines(1)
        .setupFont(AppFonts.light18.font)
        .setupTextAligment(.center)
        .setupTextColor(.white)
        .build()
    
    private let dataLabel = LabelBuilder()
        .setupNumberOfLines(1)
        .setupFont(AppFonts.regular20.font)
        .setupTextAligment(.left)
        .setupadjustsFontSizeToFitWidth(true)
        .setupTextColor(.white)
        .build()
    
    init(type: Atmosphere) {
        super.init(frame: .zero)
        self.configureView(with: type)
        self.setupHumiditydSectionView()
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

private extension SectionWithSeparatorView {
    
    func configureView(with type: Atmosphere) { self.imageView.image = type.image
        self.nameLabel.text = type.description
        
    }
    
    func setupHumiditydSectionView() {
        self.setupLayout()
        self.displayData()
    }
    
    func displayData() {
        self.separatorLabel.text = "|"
    }
    
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
            make.trailing.equalToSuperview()
        }
    }
}
