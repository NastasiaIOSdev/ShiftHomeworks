//
//  ModelAboutMe.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 09.05.2022.
//

import Foundation
import class UIKit.UIImage

struct AboutMeModel {
    let header: String
    let avatar: UIImage?
    let name: String
    let surname: String
    let age: String
    let education: String
    let city: String
}

extension AboutMeModel {
    init(
        
    ) {
        self.header = "Обо мне :"
        self.avatar = UIImage(named: "myAvatar")
        self.name = "✓  Имя: Анастасия"
        self.surname = "✓  Фамилия: Ларина"
        self.age = "✓  Возраст: 37 лет"
        self.education = "✓  Образование: ЧелГУ\n- Магистр: Финансы и кредит\n- Бакалавр: Прикладная информатика, студент"
        self.city = "✓  Город: Челябинск"
    }
}
