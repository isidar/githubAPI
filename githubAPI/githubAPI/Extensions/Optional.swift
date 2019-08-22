//
//  Optional.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 8/21/19.
//  Copyright © 2019 Nazarii Melnyk. All rights reserved.
//

import Foundation

extension Optional where Wrapped: LosslessStringConvertible {
    func string(ifNil: String) -> String {
        if case .some(let stringConvertable) = self {
            return String(stringConvertable)
        }
        return ifNil        
    }
}
