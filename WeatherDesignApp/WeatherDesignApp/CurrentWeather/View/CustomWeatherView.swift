//
//  CustomWeatherView.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

protocol ICustomWeatherView: AnyObject {
    var buttonTappedHandler: (() -> ())? { get set }
    func displayWeatherData(_ viewModel: CurrentWeatherViewModel)
}

final class CustomWeatherView: UIView, ICustomWeatherView {
    
    // MARK: - Properties
    
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
    
    private let searchTextField = UISearchTextField()
    private let weatherIconImageView = UIImageView()
    private let weatherWidgetView = WeatherWidgetView()
    
    private lazy var newNoteButton = WeatherButton(settings: .init(
        imageName: Constancts.weatherButtonImage,
        labelText: Texts.buttonImageText,
        font: .regular16,
        tapHandler: { self.buttonTappedHandler?() }))
    
    var buttonTappedHandler: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayWeatherData(_ viewModel: CurrentWeatherViewModel) {
        self.weatherIconImageView.image = viewModel.weatherType.image
        self.weatherWidgetView.displayWeatherData(viewModel)
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