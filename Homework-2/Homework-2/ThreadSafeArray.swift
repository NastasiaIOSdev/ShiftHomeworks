//
//  ThreadSafeArray.swift
//  Homework-2
//
//  Created by Анастасия Ларина on 02.05.2022.
//

import Foundation

struct ThreadSafeArray<T> {
    
    var count: Int {
        semafore.wait()
        let countArray = safeArray.count
        semafore.signal()
        return countArray
    }
    private var safeArray = [T]()
    private let semafore = DispatchSemaphore(value: 1)
}


extension ThreadSafeArray {
    
    mutating func append(_ item: T) {
        semafore.wait()
        safeArray.append(item)
        semafore.signal()
    }
    
    var isEmpty: Bool {
        semafore.wait()
        let arrayIsEmpty = safeArray.isEmpty
        semafore.signal()
        return arrayIsEmpty
    }
    
    mutating func remove(at index: Int) {
        semafore.wait()
        if index < safeArray.count {
            safeArray.remove(at: index)
        }
        semafore.signal()
    }
    
    func contains(_ element: T) -> Bool where T:Equatable {
        semafore.wait()
        let containsElement = safeArray.contains(element)
        semafore.signal()
        return containsElement
    }
    
    subscript(index: Int) -> T {
        semafore.wait()
        let element = safeArray[index]
        semafore.signal()
        return element
    }
}



