//
//  AtomicClass.swift
//  TriggerStop
//
//  Created by T.J. Stone on 7/24/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import Foundation

/**
 * Provides thread safe getter/setter methods for  primitive data types.
 */
final class Atomic<A> {
    private let queue = DispatchQueue(label: "Atomic serial queue")
    private var _value: A
    init(_ value: A) {
        self._value = value
    }
    
    var value: A {
        get {
            return queue.sync { self._value }
        }
    }
    
    func mutate(_ transform: (inout A) -> ()) {
        queue.sync {
            transform(&self._value)
        }
    }
}
