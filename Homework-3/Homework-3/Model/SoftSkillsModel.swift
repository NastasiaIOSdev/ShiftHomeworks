//
//  ModelSoftSkills.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 09.05.2022.
//

import Foundation
import class UIKit.UIImage

struct SoftSkillsModel {
    let header: String
    let softSkill1: String
    let softSkill2: String
    let softSkill3: String
    let softSkill4: String
    let hobby: String
    let avatar: UIImage?
}

extension SoftSkillsModel {
    init(
        
    ) {
        self.header = "📝 Soft skills :"
        self.softSkill1 = "→  Procreate"
        self.softSkill2 = "→  AdobyPhotoShop"
        self.softSkill3 = "→  IMovie"
        self.softSkill4 = "→  2D Animation & Illustration"
        self.hobby = "→  Велосипед, Йога, Походы, English"
        self.avatar = UIImage(named: "myAvatar2")
    }
}
