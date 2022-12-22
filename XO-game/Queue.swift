//
//  Queue.swift
//  HedTools
//
//  Created by Aleksandr Derevenskih on 16.04.2022.
//

import Foundation

/// Queue
struct Queue<T> {
    var items: [T] = []
    mutating func push(_ element: T) {
        items.append(element)
    }
    mutating func dequeue() -> T? {
        if !items.isEmpty {
            return items.removeFirst()
        }
        return nil
    }
}
