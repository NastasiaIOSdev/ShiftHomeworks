//
//  ViewController.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit
import SnapKit

class CurrentWeatherViewController: UIViewController {
    
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
        tapHandler: { self.saveButtonTapped() }))
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.displayWeatherData(CurrentWeatherViewModel())
    }
    
    func displayWeatherData(_ viewModel: CurrentWeatherViewModel) {
        self.weatherIconImageView.image = viewModel.weatherType.image
        self.weatherWidgetView.displayWeatherData(viewModel)
    }
}

// MARK: - Navigation

private extension CurrentWeatherViewController {
    func saveButtonTapped() {
        self.present(WeatherNoteViewControllerAssembly.build(), animated: true)
    }
}

// MARK: - NetworkRequest
 
private extension CurrentWeatherViewController {
    func requestCurrentWeather(for city: String?) {
        print(city)
    }
}

private extension CurrentWeatherViewController {
    func setupUI() {
        self.setupBackgroundView()
        self.configureWidgetView()
        self.setupSearchField()
        self.setAccessibilityIdentifier()
        self.setupLayout()
        
    }
    func setupBackgroundView() {
        self.view.insertSubview(UIImageView(image: UIImage(named: "background")), at: 0)
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
        searchTextField.leftViewMode = .always
        searchTextField.leftView = emptyView
        searchTextField.rightViewMode = .always
        searchTextField.rightView = emptyView
        
        self.weatherIconImageView.image = UIImage(named: "sunny")
    }
    
    func configureWidgetView() {
        weatherWidgetView.backgroundColor = Colors.whiteBackground.value
        weatherWidgetView.layer.cornerRadius = Constancts.cornerRadius
        weatherWidgetView.layer.borderColor = UIColor.white.cgColor
        weatherWidgetView.layer.borderWidth = 1
    }
    
    func setupLayout() {
        self.view.addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalSearchOffset)
            make.height.equalTo(Constancts.searchHeight)
        }
        
        self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.view.addSubview(self.weatherIconImageView)
        self.weatherIconImageView.snp.makeConstraints { make in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(Constraints.topImageViewOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.weatherIconImageView.snp.height)
        }
        
        self.view.addSubview(self.weatherWidgetView)
        self.weatherWidgetView.snp.makeConstraints { make in
            make.top.equalTo(self.weatherIconImageView.snp.bottom).offset(Constraints.topImageViewOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.horisontalSearchOffset)
        }
        
        self.view.addSubview(self.newNoteButton)
         self.newNoteButton.snp.makeConstraints { make in
             make.top.equalTo(self.weatherWidgetView.snp.bottom).offset(Constraints.buttonTopOffset)
             make.centerX.equalToSuperview()
             make.leading.lessThanOrEqualToSuperview().offset(Constraints.buttonHorisontalOffset)
             make.trailing.lessThanOrEqualToSuperview().offset(-Constraints.buttonHorisontalOffset).priority(.low)
             make.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(Constraints.buttonBottomOffset)
         }
    }
    
    func setAccessibilityIdentifier() {
        self.weatherIconImageView.accessibilityIdentifier = "weatherIconImageView"
    }
}

extension CurrentWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.requestCurrentWeather(for: textField.text)
        return true
    }
}
