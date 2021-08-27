//
//  Dictionary+Helpers.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

extension Dictionary {
    /// Appends elements if `other` to `self` and returns the result.
    /// - Parameter other: The other dictionary.
    /// - Returns: The result of appending `other` to `self`.
    func appending(elementsOf other: [Key: Value]) -> [Key: Value] {
        var memo = self
        for (key, value) in other {
            memo[key] = value
        }
        return memo
    }
    
    /// Appends elements of `other` to `self`.
    /// - Parameter other: The other dictionary.
    mutating func append(elementsOf other: [Key: Value]) {
        self = appending(elementsOf: other)
    }
}
