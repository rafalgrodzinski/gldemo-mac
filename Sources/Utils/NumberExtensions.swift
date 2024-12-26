//
//  NumberExtensions.swift
//  glDemo
//
//  Created by Rafal on 26/12/2024.
//

import Foundation

extension Float {
    func clamp(_ range: ClosedRange<Float>) -> Float {
        if self < range.lowerBound {
            return range.lowerBound
        } else if self > range.upperBound {
            return range.upperBound
        }
        return self
    }
}
