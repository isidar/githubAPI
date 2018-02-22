//
//  Array.swift
//  githubAPI
//
//  Created by Nazarii Melnyk on 2/22/18.
//  Copyright © 2018 Nazarii Melnyk. All rights reserved.
//

import Foundation

extension Array {
    func printElements() -> String {
        var str = ""
        
        for element in self {
            str += "\(element), "
        }
        if !str.isEmpty {
            str.removeLast()
            str.removeLast()
        }
        
        return str
    }
}
