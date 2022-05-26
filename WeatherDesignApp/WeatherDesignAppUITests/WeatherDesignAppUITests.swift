//
//  WeatherDesignAppUITests.swift
//  WeatherDesignAppUITests
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import XCTest

class WeatherDesignAppUITests: XCTestCase {
    func testExample() {
        let app = XCUIApplication()
        app.launch()
        self.checkLabelExist(withId: "weatherDescribeLabel")
    }
}

extension XCTestCase {
    func checkLabelExist(withId id: String) {
        let app = XCUIApplication()
        let isExist = app.staticTexts[id].exists
        XCTAssertTrue(isExist)
    }

    func checkLabelText(labelId: String, text: String) {
        let app = XCUIApplication()
        let labelText = app.staticTexts[labelId].label
        XCTAssertEqual(labelText, text)
    }

    func checkImageViewExist(withId id: String) {
        let app = XCUIApplication()
        let isExist = app.images[id].exists
        XCTAssertTrue(isExist)
    }
}
