//
//  LabelBuilder.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import UIKit

final class LabelBuilder {
    private var label: UILabel
    
    init() {
        label = UILabel()
    }
}

extension LabelBuilder {
    func setupTextColor(_ textColor: UIColor) -> LabelBuilder {
        label.textColor = textColor
        return self
    }
    
    func setupFont(_ font: UIFont?) -> LabelBuilder {
        label.font = font
        return self
    }
    
    func setupTextAligment(_ textAligment: NSTextAlignment) -> LabelBuilder {
        label.textAlignment = textAligment
        return self
    }
    
    func setupadjustsFontSizeToFitWidth(_ bool: Bool) -> LabelBuilder {
        label.adjustsFontSizeToFitWidth = bool
        return self
    }
    
    func setupNumberOfLines(_ numberOfLines: Int) -> LabelBuilder {
        label.numberOfLines = numberOfLines
        return self
    }
    
    func setupMinimumScaleFactor(_ minimumScaleFactor: CGFloat) -> LabelBuilder {
        label.minimumScaleFactor = minimumScaleFactor
        return self
    }
    
    func setupLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> LabelBuilder {
        label.lineBreakMode = lineBreakMode
        return self
    }
    
    func setupsizeToFit() -> LabelBuilder {
        label.sizeToFit()
        return self
    }
    
    func setupText(_ text: String) -> LabelBuilder {
        label.text = text
        return self
    }
    
    func build() -> UILabel { label }
}
