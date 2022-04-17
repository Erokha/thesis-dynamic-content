//
//  NSLock.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/17/22.
//

import Foundation

public extension NSLock {
    typealias CriticalClosure = (() -> Void)
    
    func critical(_ criticalClosure: CriticalClosure?) {
        lock()
        criticalClosure?()
        unlock()
    }
}
