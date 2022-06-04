//
//  WeatherButton.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit
import SnapKit

class WeatherButton: UIView {
    
    struct Settings {
        let imageName: String?
        let labelText: String
        let font: AppFonts
        let tapHandler: () -> Void
    }
    
    // MARK: - Properties
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let borderWidth: CGFloat = 1
    }
    
    private enum Constraints {
       static let offset = 20
        static let labelImageGorizontalOffset = 12
    }
    
    private let tapHandler: () -> Void
    private var image: UIImage?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = self.image
        return imageView
    }()
    
    init(settings: Settings) {
        self.tapHandler = settings.tapHandler
        super.init(frame: .zero)
        self.configureView()
        self.configureUI(with: settings)
        self.setupLayout()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}
// MARK: - конфигурируем нижний слой

private extension WeatherButton {
    
    func configureView() {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}

// MARK: - Добавляем constraints
private extension WeatherButton {
    func setupLayout() {
        if self.image != nil {
            self.setupLayoutWithImage()
        } else {
            self.setupLayoutWithoutImage()
        }
    }
    func setupLayoutWithImage() {
        self.imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.offset)
            make.leading.equalToSuperview().offset(Constraints.offset)
        }
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.offset)
            make.leading.equalTo(self.imageView.snp.trailing).offset(Constraints.labelImageGorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constraints.offset)
        }
    }
    
    func setupLayoutWithoutImage() {
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.offset)
            make.leading.equalToSuperview().offset(Constraints.offset)
            make.trailing.equalToSuperview().offset(-Constraints.offset)
        }
        self.label.textAlignment = .center
    }
}

// MARK: - Добавляем настройки
private extension WeatherButton {
    func configureUI(with settings: Settings) {
        if let imageName = settings.imageName {
            self.image = UIImage(named: imageName)
        }
        self.label.text = settings.labelText
        self.label.font = settings.font.font
        
        let gestureRegognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        self.addGestureRecognizer(gestureRegognizer)
    }
    @objc
    func viewTapped() {
        self.tapHandler()
    }
}

