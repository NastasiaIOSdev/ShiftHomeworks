//
//  ModelHardSkills.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 09.05.2022.
//

import Foundation
import class UIKit.UIImage

struct HardSkillsModel {
    let header: String
    let hardSkill1: String
    let hardSkill2: String
    let hardSkill3: String
    let hardSkill4: String
    let howLongHaveBeenProgramming: String
    let whatIexpextFromTheShiftCourses: String
}

extension HardSkillsModel {
    init(
        
    ) {
        self.header = "🛠 Hard skills :"
        self.hardSkill1 = "→  Swift"
        self.hardSkill2 = "→  UIKit"
        self.hardSkill3 = "→  Xcode"
        self.hardSkill4 = "→  Git"
        self.howLongHaveBeenProgramming = "→  Изучaю Swift и разработку под IOS в общей сложности 8 месяцев.\nЭто самое интересное для меня направление - разработка мобильных приложения под IOS!"
        self.whatIexpextFromTheShiftCourses = "→  На обучении в ШИФТ школе хочу повысит экспертизу. Буду рада сотрудничеству с ЦФТ в ФинТех."
    }
}
