//
//  CustomWeatherView.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

protocol ICustomWeatherView: AnyObject {
    var buttonTappedHandler: (() -> ())? { get set }
    func displayWeatherData(data: CurrentWeatherViewModel)
    func setImage(imageData: Data)
}

final class CustomWeatherView: UIView {
    
    // MARK: - Properties
    private let weatherSearchServise = NetworkService()
    private let weatherService = WeatherService()
    private let weatherWidgetView = WeatherWidgetView()
    private let sectionWithSeparatorViewHum = SectionWithSeparatorView(type: .humidity)
    private let sectionWithSeparatorViewWind = SectionWithSeparatorView(type: .wind)
    
    private enum Constancts {
        static let searchHeight = 58
        static let imageViewSize = 142
        static let cornerRadius: CGFloat = 16
        static let weatherButtonImage = "edit"
    }
    
    private enum Constraints {
        static let topSearchOffset = 34
        static let horisontalSearchOffset = 30
        static let emptyViewWidth = 16
        static let topImageViewOffset = 36
        static let buttonTopOffset = 35
        static let buttonHorisontalOffset = 97
        static let buttonBottomOffset = -30
    }
    
    private enum Texts {
        static let searchTFPlaceholder = "Search here"
        static let buttonImageText = "New wether note"
    }
    
    let searchTextField = UITextField()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var newNoteButton = WeatherButton(settings: .init(
        imageName: Constancts.weatherButtonImage,
        labelText: Texts.buttonImageText,
        font: .regular16,
        tapHandler: { self.buttonTappedHandler?() }))
    
    var buttonTappedHandler: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
        searchTextField.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}

extension CustomWeatherView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dispalayCondition(textField)
        displayLocation(textField)
        dispalayCurrentWeather(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CustomWeatherView {
    func dispalayCondition(_ textField: UITextField) -> Void {
        self.weatherService.getCondition(textField.text!) { (condition) in
            if let condition = condition {
                DispatchQueue.main.async {
                    if let icon = URL(string: "https:\(condition.icon!)") {
                        self.weatherIconImageView.load(url: icon)
                    }
                    if let text = URL(string: "\(condition.text!)") {
                        self.weatherWidgetView.weatherDescription.text = "\(text)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.weatherIconImageView.image = nil
                    self.weatherWidgetView.weatherDescription.text = nil
                }
            }
        }
    }
    
    func dispalayCurrentWeather(_ textField: UITextField) -> Void {
        self.weatherService.getCurrentweather((textField.text!)) { (currentWeather) in
            if let currentWeather = currentWeather {
                DispatchQueue.main.async {
                    if let temp = currentWeather.temp {
                        self.weatherWidgetView.bigTemperatureLabel.text = "\(temp)°C"
                    }

                    if let hun = currentWeather.humidity {
                        self.weatherWidgetView.humiditySectionView.dataLabel.text = "\(hun) %"
                    }

                    if let wind = currentWeather.wind {
                        self.weatherWidgetView.windSectionView.dataLabel.text = "\(wind)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.weatherWidgetView.humiditySectionView.dataLabel.text = nil
                    self.sectionWithSeparatorViewHum.dataLabel.text = nil
                    self.weatherWidgetView.windSectionView.dataLabel.text = nil
                }
            }
        }
    }
    
    func displayLocation(_ textField: UITextField) -> Void {
        weatherService.getLocation("\(textField.text!)") { (location) in
            if let location = location {
                DispatchQueue.main.async {
                    var locationText = ""
                    if let city = location.city {
                        locationText = "\(city)"
                    }
                    self.searchTextField.text = "\(locationText)"
                }
            } else {
                DispatchQueue.main.async {
                    self.searchTextField.text = "Город не найден"
                }
            }
        }
    }
}

extension CustomWeatherView: ICustomWeatherView {
    
    func setImage(imageData: Data) {
        self.weatherIconImageView.image = UIImage(data: imageData)
    }
    
    func displayWeatherData(data: CurrentWeatherViewModel) {
        self.weatherWidgetView.displayWeatherData(data)
    }
}

private extension CustomWeatherView {
    func setupUI() {
        self.setupBackgroundView()
        self.setupSearchField()
        self.configureWidgetView()
        self.setupLayout()
        self.setAccessibilityIdentifier()
    }
    
    func setupBackgroundView() {
        self.insertSubview(UIImageView(image: UIImage(named: "background")), at: 0)
    }
    
    func setupSearchField() {
        self.searchTextField.backgroundColor = Colors.white.value
        self.searchTextField.layer.cornerRadius = Constancts.cornerRadius
        self.searchTextField.layer.masksToBounds = true
        self.searchTextField.attributedPlaceholder = NSAttributedString(
            string: Texts.searchTFPlaceholder,
            attributes: [NSAttributedString.Key.font : AppFonts.regular18.font as Any,
                         NSAttributedString.Key.foregroundColor : Colors.lightBlue.value
                        ]
        )
        let emptyView = UIView(frame: .init(x: .zero, y: .zero, width: Constraints.emptyViewWidth, height: .zero))
        self.searchTextField.leftViewMode = .always
        self.searchTextField.leftView = emptyView
        self.searchTextField.rightViewMode = .always
        self.searchTextField.rightView = emptyView
        
        self.weatherIconImageView.image = UIImage(named: "sunny")
    }
    
    func configureWidgetView() {
        self.weatherWidgetView.backgroundColor = Colors.whiteBackground.value
        self.weatherWidgetView.layer.cornerRadius = Constancts.cornerRadius
        self.weatherWidgetView.layer.borderColor = UIColor.white.cgColor
        self.weatherWidgetView.layer.borderWidth = 1
    }
    
    func setupLayout() {
        self.setupSearchTFLayout()
        self.setupWeatherImageViwLayout()
        self.setupWeatherWidgetViewLayout()
        self.setupButtonLayout()
    }
    
    func setupSearchTFLayout() {
        self.addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalSearchOffset)
            make.height.equalTo(Constancts.searchHeight)
        }
    }
    
    func setupWeatherImageViwLayout() {
        self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.addSubview(self.weatherIconImageView)
        self.weatherIconImageView.snp.makeConstraints { make in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(Constraints.topImageViewOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.weatherIconImageView.snp.height)
        }
    }
    
    func setupWeatherWidgetViewLayout() {
        self.addSubview(self.weatherWidgetView)
        self.weatherWidgetView.snp.makeConstraints { make in
            make.top.equalTo(self.weatherIconImageView.snp.bottom).offset(Constraints.topImageViewOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalSearchOffset)
        }
    }
    
    func setupButtonLayout() {
        self.addSubview(self.newNoteButton)
        self.newNoteButton.snp.makeConstraints { make in
            make.top.equalTo(self.weatherWidgetView.snp.bottom).offset(Constraints.buttonTopOffset)
            make.centerX.equalToSuperview()
            make.leading.lessThanOrEqualToSuperview().offset(Constraints.buttonHorisontalOffset)
            make.trailing.lessThanOrEqualToSuperview().offset(-Constraints.buttonHorisontalOffset).priority(.low)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(Constraints.buttonBottomOffset)
        }
    }
    
    func setAccessibilityIdentifier() {
        self.weatherIconImageView.accessibilityIdentifier = "weatherIconImageView"
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
