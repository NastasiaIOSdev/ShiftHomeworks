//
//  WeatherNoteCell.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit
import SnapKit

final class WeatherNoteCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let id = String(describing: WeatherNoteCell.self)
    
    private enum Constraints {
        static let topBottonInset: CGFloat = 18
        static let horisontalOffset: CGFloat = 25
        static let heightWidthImageView: CGFloat = 48
        static let leadingTrailingCellInset: CGFloat = 16
        static let degreeLabelWidth = 40
    }
    private let cityLabel = LabelBuilder()
        .setupFont(AppFonts.bold24.font)
        .setupTextColor(.white)
        .setupTextAligment(.left)
        .setupadjustsFontSizeToFitWidth(true)
        .build()

    private let dateLabel = LabelBuilder()
        .setupFont(AppFonts.regular20.font)
        .setupTextColor(.white)
        .setupTextAligment(.center)
        .build()
    
    private let degreeLabel = LabelBuilder()
        .setupFont(AppFonts.regular20.font)
        .setupTextColor(.white)
        .setupTextAligment(.right)
        .build()
    
    private let weatherImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherNoteCell {
    func displayData(_ viewModel: WeatherDiaryEntity) {
        self.cityLabel.text = viewModel.town
        self.dateLabel.text = viewModel.date
        self.weatherImageView.image = viewModel.weatherImage.image
        self.degreeLabel.text = viewModel.temperature
    }
}

private extension WeatherNoteCell {
    
    func setupUI() {
        self.setupLayout()
        self.setupCommonData()
    }
    
    func setupCommonData() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func setupLayout() {
        self.setupCityLabelLayout()
        self.setupDateLabelLayout()
        self.setupWeatherImageViewLayout()
        self.setupDegreeLAbelLayout()
    }
    
    func setupCityLabelLayout() {
        self.contentView.addSubview(self.cityLabel)
        self.cityLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.topBottonInset)
            make.leading.equalToSuperview().offset(Constraints.leadingTrailingCellInset)
            make.centerY.equalToSuperview().priority(.high)
        }
    }
    
    func setupDateLabelLayout() {
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.topBottonInset)
            make.leading.equalTo(self.cityLabel.snp.trailing).offset(Constraints.horisontalOffset)
            make.centerY.equalToSuperview().priority(.high)
        }
    }
    
    func setupWeatherImageViewLayout() {
        self.contentView.addSubview(self.weatherImageView)
        self.weatherImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.dateLabel.snp.trailing).offset(Constraints.horisontalOffset)
            make.height.width.equalTo(Constraints.heightWidthImageView)
            make.top.bottom.equalToSuperview().inset(Constraints.topBottonInset)
            make.centerY.equalToSuperview().priority(.high)
        }
    }
    
    func setupDegreeLAbelLayout() {
        self.degreeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.contentView.addSubview(self.degreeLabel)
        self.degreeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.topBottonInset)
            make.leading.equalTo(self.weatherImageView.snp.trailing).offset(Constraints.horisontalOffset)
            make.trailing.equalToSuperview().offset(-Constraints.leadingTrailingCellInset)
            make.centerY.equalToSuperview().priority(.high)
        }
    }
}

