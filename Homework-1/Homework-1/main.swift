//
//  main.swift
//  Homework-1
//
//  Created by Анастасия Ларина on 20.04.2022.
//

import Foundation

struct Car: CustomStringConvertible {
    var description: String {
        let number: String
        if let num = carNumber {
            number = "    номер: \(num)"
        } else {
            number = ""
        }
        let result = """
    марка: \(manufacturer)
    модель: \(model)
    кузов: \(body.rawValue)
    год: \(yearOfIssue?.description ?? "-")
""" + "\n" + number
        return result
    }
    
    enum Body: String, CaseIterable {
        case sedan = "Седан"
        case crossover = "Кроссовер"
        case hatchback = "Хэтчбэк"
        case unknown = "Неопределен"
    }
    
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int?
    let carNumber: String?
}

enum CommandInMenu: Int, CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
        case .addNewCar:
            return "\(self.rawValue) - Добавить новый автомобиль"
        case .showListOfCar:
            return "\(self.rawValue) - Показать список автомобилей"
        case .filterBodyCar:
            return "\(self.rawValue) - Выбор типа кузова автомобиля"
        case .exit:
            return "\(self.rawValue) - Выход"
        }
    }
    
    case addNewCar = 1
    case showListOfCar
    case filterBodyCar
    case exit = 0
}

var arrayCars: [Car] = [
    Car(manufacturer: "BPW", model: "X6", body: .crossover, yearOfIssue: nil, carNumber: "A333L"),
    Car(manufacturer: "Volvo", model: "V40", body: .sedan, yearOfIssue: 1995, carNumber: nil)
]

func startApp() {
    setupMenu()
}

func setupMenu() {
    while true {
        let command = readEnteredCommand()
        switch command {
        case .addNewCar:
            addNewCar()
        case .showListOfCar:
            printListOfCars(arrayCars: arrayCars)
        case .filterBodyCar:
            filterBodyOfCars()
        case .exit:
            return
        }
    }
}

func readEnteredCommand() -> CommandInMenu {
    while true {
        printListMenu()
        let input = readLine()
        if let commandInt = Int(input ?? ""),
           let command = CommandInMenu(rawValue: commandInt) {
            return command
        }
    }
}

func printListMenu() {
    print()
    CommandInMenu.allCases.forEach { print($0) }
}

func addNewCar() {
    let car = getCar()
    arrayCars.append(car)
}

func printListOfCars(arrayCars: [Car]) {
    arrayCars.forEach { print($0, "\n")}
}

func filterBodyOfCars() {
    let body  = getBody()
    let filteredCars = arrayCars.filter { car in
        car.body == body
    }
    printListOfCars(arrayCars: filteredCars)
}

func strongReadLine(prompt: String) -> String {
    while true {
        print(prompt)
        if let string = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), string.isEmpty == false {
            return string
        }
        print("Повторите ввод")
    }
}

func weakReadLine(prompt: String) -> String? {
    print(prompt)
    let result = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
    return result?.isEmpty ?? true ? nil : result
}


func getCar() -> Car {
    let manufacturer = strongReadLine(prompt: "Введите марку")
    let model = strongReadLine(prompt: "Введите модель")
    let body = getBody()
    let year: Int?
    if let yearString = weakReadLine(prompt: "Введите год выпуска") {
        year = Int(yearString)
    } else {
        year = nil
    }
    let number = weakReadLine(prompt: "Введите гос номер")
    
    return Car(manufacturer: manufacturer,
               model: model,
               body: body,
               yearOfIssue: year,
               carNumber: number
    )
}

func getBody() -> Car.Body {
    let bodyList = buildBodyList()
    
    var bodyString: String
    var index = 0
    repeat {
        bodyString = strongReadLine(prompt: bodyList)
        if Int(bodyString) == nil {
            continue
        }
        index = Int(bodyString) ?? 0
    } while index >= Car.Body.allCases.count || index < 0
    return Car.Body.allCases[index]
}

func buildBodyList() -> String {
    var result = "Тип Кузова:"
    
    for (index, body) in Car.Body.allCases.enumerated() {
        result += "\n\(index) - \(body.rawValue)"
    }
    
    return result
}

startApp()
