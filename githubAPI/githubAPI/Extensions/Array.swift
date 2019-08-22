//
//  Array.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

extension Array where Element: LosslessStringConvertible {    
    /// Returns string of sequence of elements in appropriate order with comma separator
    func join(withSeparator separator: String = ", ") -> String {
        return reduce(into: "") { $0 += $0.isEmpty ? "\($1)" : separator + "\($1)" }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set {
            guard let value = newValue, index < count, index >= 0 else { return }
            self[index] = value
        }
    }
}
