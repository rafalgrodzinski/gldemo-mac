//
//  TypeConversionExtensions.swift
//  glDemo
//
//  Created by Rafał on 2025/01/01.
//

import Foundation

extension FixedWidthInteger {
    var int: Int {
        Int(self)
    }

    var float: Float {
        Float(self)
    }

    var bool: Bool {
        self > 0
    }
}

extension Double {
    var float: Float {
        Float(self)
    }
}

extension Float32 {
    var float: Float {
        Float(self)
    }
}
