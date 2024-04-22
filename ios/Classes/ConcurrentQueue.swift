//
//  ConcurrentQueue.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 22/04/2024.
//

import Foundation

class ConcurrentQueue<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "com.nrf-connect-device-manager.concurrentQueue", attributes: .concurrent)
    
    func enqueue(_ element: T) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }
    
    func dequeue() -> T? {
        var result: T?
        queue.sync {
            if !array.isEmpty {
                result = array.removeFirst()
            }
        }
        return result
    }
}

