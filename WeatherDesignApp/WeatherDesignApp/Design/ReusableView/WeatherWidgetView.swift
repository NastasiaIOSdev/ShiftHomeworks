//
//  WeatherWidgetView.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation
import UIKit
import SnapKit


class WeatherWidgetView: UIView {
   
    private enum Constraints {
        static let dateLabelTopOffset = 17
        static let separatorSectionTopOffset = 37
        static let separatorSectionHorizontalOffsets = 77
        static let humidityBottomOffset = -25

    }
    
    let windSectionView = SectionWithSeparatorView(type: .wind)
    let humiditySectionView = SectionWithSeparatorView(type: .humidity)
    
    private let dateLabel = UILabel()
    private let bigTemperatureLabel = UILabel()
    private let weatherDescription = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.setupWeatherWidgetView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayWeatherData(_ viewModel: CurrentWeatherViewModel) {
        self.dateLabel.text = viewModel.date
        self.bigTemperatureLabel.text = viewModel.temp
        self.weatherDescription.text = viewModel.weatherType.description.capitalized
        self.windSectionView.setData(viewModel.wind)
        self.humiditySectionView.setData(viewModel.humidity)
    }
}

private extension WeatherWidgetView {
 
    func setupWeatherWidgetView() {
        self.displayWeatherData(CurrentWeatherViewModel())
        self.setupCommonData()
        self.setupCommonLabelLayout()
    }
   
    func setupCommonData() {
        self.dateLabel.numberOfLines = 1
        self.dateLabel.adjustsFontSizeToFitWidth = true
        self.dateLabel.textAlignment = .center
        self.dateLabel.minimumScaleFactor = 0.5
        self.dateLabel.font = AppFonts.regular18.font
        self.dateLabel.textColor = .white
        
        self.bigTemperatureLabel.numberOfLines = 1
        self.bigTemperatureLabel.adjustsFontSizeToFitWidth = true
        self.bigTemperatureLabel.textAlignment = .center
        self.bigTemperatureLabel.font = AppFonts.regular100.font
        self.bigTemperatureLabel.textColor = .white
        
        self.weatherDescription.numberOfLines = 1
        self.weatherDescription.adjustsFontSizeToFitWidth = true
        self.weatherDescription.textAlignment = .center
        self.weatherDescription.font = AppFonts.bold24.font
        self.weatherDescription.textColor = .white
    }
    
    func setupCommonLabelLayout() {
        
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Constraints.dateLabelTopOffset)
            make.trailing.leading.equalToSuperview()
        }
        
        self.addSubview(self.bigTemperatureLabel)
        self.bigTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(self.weatherDescription)
        self.weatherDescription.snp.makeConstraints { make in
            make.top.equalTo(self.bigTemperatureLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        self.windSectionView.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        self.addSubview(self.windSectionView)
        self.windSectionView.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().priority(.high)
            make.top.equalTo(self.weatherDescription.snp.bottom).offset(Constraints.separatorSectionTopOffset)
            make.centerX.equalToSuperview().priority(.high)
            make.trailing.lessThanOrEqualToSuperview().priority(.low)
            make.leading.lessThanOrEqualToSuperview().priority(.low)
        }

        self.humiditySectionView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addSubview(self.humiditySectionView)
        self.humiditySectionView.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().priority(.high)
            make.top.equalTo(self.windSectionView.snp.bottom)
            make.centerX.equalToSuperview().priority(.high)
            make.trailing.lessThanOrEqualToSuperview().priority(.low)
            make.leading.lessThanOrEqualToSuperview().priority(.low)
            make.bottom.equalTo(self).offset(Constraints.humidityBottomOffset)
        }
    }
}
