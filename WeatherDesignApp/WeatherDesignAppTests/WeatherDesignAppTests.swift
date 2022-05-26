//
//  WeatherDesignAppTests.swift
//  WeatherDesignAppTests
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import XCTest
@testable import WeatherDesignApp

class DateConverterTests: XCTestCase {
    func testFormatterCurrentDate() {
        XCTAssertTrue(DateConverter.showDayWithWeekDay(Date.now).contains("Today"))
    }

    func testFormatterOtherDate() {
        let date = Date(timeIntervalSince1970: 1651513837)
        print(date)
        XCTAssertEqual(DateConverter.showDayWithWeekDay(date), "Mon, 2 May")
    }
}
