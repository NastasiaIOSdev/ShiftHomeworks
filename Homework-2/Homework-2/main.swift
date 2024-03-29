//
//  main.swift
//  Homework-2
//
//  Created by Анастасия Ларина on 02.05.2022.
//

import Foundation

var safeArray = ThreadSafeArray<Int>()

let queue = DispatchQueue(label: "Save", attributes: .concurrent)

let group1 = DispatchGroup()

group1.enter()
queue.async {
    for number in 0...1000 {
        safeArray.append(number)
    }
    group1.leave()
}

group1.enter()
queue.async {
    for number in 0...1000 {
        safeArray.append(number)
    }
    group1.leave()
}

group1.wait()

print("Задача выполнена! Количество элементов в массиве: ", safeArray.count)

