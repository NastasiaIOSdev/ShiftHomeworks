//
//  ThreadSafeArray.swift
//  Homework-2
//
//  Created by Анастасия Ларина on 02.05.2022.
//

import Foundation

struct ThreadSafeArray<T> {
    
    var count: Int {
        let countArray = safeArray.count
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
    
    private var isEmpty: Bool {
        let arrayIsEmpty = safeArray.isEmpty
        return arrayIsEmpty
    }
    
    private mutating func remove(at index: Int) {
        safeArray.remove(at: index)
    }
    
    private func contains(_ element: T) -> Bool where T:Equatable {
        let containsElement = safeArray.contains { _ in element as! Bool }
        return containsElement
    }
    
    private subscript(index: Int) -> T {
        return safeArray[index]
    }
}



