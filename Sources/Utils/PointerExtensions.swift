//
//  PointerExtensions.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import GLKit

extension GLKMatrix4 {
    func pointer(handler: (UnsafePointer<GLfloat>) -> Void) {
        var m = self.m
        withUnsafePointer(to: &m) { unsafePointer in
            unsafePointer.withMemoryRebound(to: GLfloat.self, capacity: 16) { reboundPointer in
                handler(reboundPointer)
            }
        }
    }
}
