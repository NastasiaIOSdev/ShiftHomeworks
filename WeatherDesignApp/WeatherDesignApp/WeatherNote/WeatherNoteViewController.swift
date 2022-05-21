//
//  WeatherNoteViewController.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit
import SnapKit

final class WeatherNoteViewController: UIViewController {
    
    // MARK: - Properties
    
    private enum Constraints {
        static let noteTextFieldNoteHotizontalInset = 30
        static let dateAndWeatherTempInfoLabelTopOffset = 24
        static let standartHorizontalInsset = 30
        static let pickerViewTopOffset: CGFloat = 5
        static let pickerBorderWith: CGFloat = 1
        static let topButtonOffset = 25
        static let leadingButtonOffset = 100
        static let saveButonHorizontalInset = 90
    }
    
    private enum Texts {
        static let cityHeader = "City"
        static let dateHeader = "Date"
        static let weatherHeader = "Weather"
        static let tempHeader = "Temperature"
        static let infoHeader = "Aditional Info"
        static let saveButton = " Save"
    }
    
    private let scrollView = UIScrollView()
    
    private let cityNoteTFView = NoteTextFieldView(settings: .init(header: Texts.cityHeader))
    private lazy var dateLabel = self.createLabel(with: Texts.dateHeader)
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "en")
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = UIColor.white.cgColor
        datePicker.backgroundColor = Colors.whiteBackground.value
        return datePicker
    }()
    //private let weatherImages = Weather.allCases
    private lazy var weatherLabel = self.createLabel(with: Texts.weatherHeader)
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        pickerView.overrideUserInterfaceStyle = .unspecified
        pickerView.backgroundColor = Colors.whiteBackground.value
        return pickerView
    }()
    
    private let temperatureTFView = NoteTextFieldView(settings: .init(header: Texts.tempHeader))
    private let additionalInfoTFView = NoteTextFieldView(settings: .init(header: Texts.infoHeader))
    
    private lazy var saveButton = WeatherButton(settings: .init(
        imageName: nil,
        labelText: Texts.saveButton,
        font: .regular16,
        tapHandler: {
            self.saveButtonTapped()
        }))
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insertSubview(UIImageView(image: UIImage(named: "background")), at: 0)
        self.navigationController?.navigationBar.tintColor = Colors.white.value
        self.setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension WeatherNoteViewController {
    func displayData(_ viewModel: WeatherNoteViewModel) {
        let weather = WeatherType.allCases.firstIndex(of: viewModel.weatherType ?? .sunny) ?? 0
        self.pickerView.selectRow(weather, inComponent: 1, animated: false)
        self.datePicker.date = viewModel.date ?? Date.now
        self.cityNoteTFView.text = viewModel.city
        self.temperatureTFView.text = String(describing: viewModel.temperature)
        self.additionalInfoTFView.text = viewModel.additionalInfo
        
    }
    
    func saveData(_ viewModel: WeatherNoteViewModel) {
        let viewModelData = WeatherNoteViewModel(
            city: self.cityNoteTFView.text,
            date: self.datePicker.date,
            weatherType: WeatherType.allCases[self.pickerView.selectedRow(inComponent: 1)],
            temperature: Int(self.temperatureTFView.text ?? ""),
            additionalInfo: self.additionalInfoTFView.text)
    }
}

private extension WeatherNoteViewController {
    
    func setupLayout() {
        
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)        }
        
        self.scrollView.addSubview(self.cityNoteTFView)
        self.cityNoteTFView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.dateAndWeatherTempInfoLabelTopOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.standartHorizontalInsset)
        }
        self.scrollView.addSubview(self.dateLabel)
        self.dateLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cityNoteTFView.snp.bottom).offset(Constraints.dateAndWeatherTempInfoLabelTopOffset)
            make.leading.equalToSuperview().offset(Constraints.standartHorizontalInsset)
        }
        self.scrollView.addSubview(self.datePicker)
        self.datePicker.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(self.dateLabel)
            make.trailing.equalToSuperview().inset(Constraints.standartHorizontalInsset)
        }
        
        self.scrollView.addSubview(self.weatherLabel)
        self.weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(Constraints.dateAndWeatherTempInfoLabelTopOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.standartHorizontalInsset)
        }
        
        self.scrollView.addSubview(self.pickerView)
        self.pickerView.snp.makeConstraints { make in
            make.top.equalTo(self.weatherLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(Constraints.standartHorizontalInsset)
        }
        
        self.scrollView.addSubview(self.temperatureTFView)
        self.temperatureTFView.snp.makeConstraints { make in
            make.top.equalTo(self.pickerView.snp.bottom).offset(Constraints.dateAndWeatherTempInfoLabelTopOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.standartHorizontalInsset)
        }
        self.scrollView.addSubview(self.additionalInfoTFView)
        self.additionalInfoTFView.snp.makeConstraints { make in
            make.top.equalTo(self.temperatureTFView.snp.bottom).offset(Constraints.dateAndWeatherTempInfoLabelTopOffset)
            make.leading.trailing.equalToSuperview().inset(Constraints.standartHorizontalInsset)
        }
        
        self.scrollView.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.top.equalTo(self.additionalInfoTFView.snp.bottom).offset(Constraints.topButtonOffset)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constraints.saveButonHorizontalInset)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveButtonTapped() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

private extension WeatherNoteViewController {
    func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = AppFonts.bold28.font
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }
}

extension WeatherNoteViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(
            string: WeatherType.allCases[row].description,
            attributes: [
                NSAttributedString.Key.font: AppFonts.regular18.font as Any,
                NSAttributedString.Key.foregroundColor: Colors.white.value
            ]
        )
    }
}

extension WeatherNoteViewController: UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return WeatherType.allCases.count
    }
    
}
