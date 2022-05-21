//
//  NoteTextFieldView.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit
import SnapKit

class NoteTextFieldView: UIView {
    
    struct Settings {
        let header: String
        let value: String?
        
        init(header: String, value: String? = nil) {
            self.header = header
            self.value = value
        }
    }
    
    // MARK: - Properties
    
    private enum Constraints {
        static let textFieldtopOffset: CGFloat = 8
    }
    
    private enum Constants {
        static let emptyViewWith: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let textFieldHeight: CGFloat = 48
        static let borderWidth: CGFloat = 1
    }
    
    private enum Texts {
        static let textFieldPalaceHolderText = "Start typing here"
    }
    
    public var text: String? {
        get {
            return self.textField.text
        }
        set {
            self.textField.text = newValue
        }
    }
    
    public var delegate: UITextFieldDelegate? {
        get {
            return nil
        }
        set {
            self.textField.delegate = newValue
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = AppFonts.bold28.font
        label.text = "Start typing here"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: Texts.textFieldPalaceHolderText,
                    attributes: [
                        NSAttributedString.Key.font: AppFonts.regular16.font as Any,
                        NSAttributedString.Key.foregroundColor: Colors.white.value
                    ]
                )
        textField.backgroundColor = Colors.whiteBackground.value
        textField.layer.borderWidth = Constants.borderWidth
        textField.layer.borderColor = Colors.white.cgColor
        textField.layer.cornerRadius = Constants.cornerRadius
        let emptyView = UIView(frame: .init(x: .zero, y: .zero, width: Constants.emptyViewWith, height: .zero))
        textField.leftViewMode = .always
        textField.leftView = emptyView
        textField.rightViewMode = .always
        textField.rightView = emptyView
        return textField
    }()
    
    init(settings: Settings) {
        super.init(frame: .zero)
        self.setupUI()
        self.configureView(with: settings)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NoteTextFieldView {
    
    func configureView(with settings: Settings) {
        self.label.text = settings.header
        self.textField.text = settings.value
    }
    
    func setupUI() {
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(self.label.snp.bottom).offset(Constraints.textFieldtopOffset)
            make.height.equalTo(Constants.textFieldHeight)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
