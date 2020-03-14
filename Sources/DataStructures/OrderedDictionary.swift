//
//  OrderedDictionary.swift
//  SwiftDataStructures
//
//  Created by Tim Ekl on 6/2/14.
//  Copyright (c) 2014 Tim Ekl. Available under MIT License. See LICENSE.md.
//

import Foundation
import SwiftAlgorithmClub

public struct OrderedDictionary<K: Hashable & Comparable, V> {
    var keys: OrderedArray<K>!
    var values: Dictionary<K,V> = [:]
    
    var count: Int {
        assert(keys.count == values.count, "Keys and values array out of sync")
        return self.keys.count;
    }
    
    // Explicitly define an empty initializer to prevent the default memberwise initializer from being generated
    public init(allowDuplicates: Bool) {
        keys = OrderedArray<K>(array: [], allowDuplicates: allowDuplicates)
    }

    public subscript(index: Int) -> V? {
        get {
            let key = self.keys[index]
            return self.values[key]
        }
        set(newValue) {
            let key = self.keys[index]
            if (newValue != nil) {
                self.values[key] = newValue
            } else {
                self.values.removeValue(forKey: key)
                _ = self.keys.removeAtIndex(index)
            }
        }
    }
    
    public subscript(key: K) -> V? {
        get {
            return self[key, .exactonly]
        }
        set(newValue) {
            self[key, .exactonly] = newValue
        }
    }
    
    public subscript(key: K, match: OrderedArray<K>.Match) -> V? {
        get {
            return self.values[key]
        }
        set(newValue) {
            if newValue == nil {
                self.values.removeValue(forKey: key)
                assert(self.keys.remove(key) == key)
            } else {
                let oldValue = self.values.updateValue(newValue!, forKey: key)
                if oldValue == nil {
                    _ = self.keys.insert(key)
                }
            }
        }
    }

    public var description: String {
        var result = "{\n"
        for i in 0..<self.count {
            result += "[\(i)]: \(self.keys[i]) => \(self[i])\n"
        }
        result += "}"
        return result
    }
}
