//
//  Camera.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import OpenGL.GL
import GLKit

final class Camera {
    private(set) var projectionMatrix: GLKMatrix4

    init() {
        projectionMatrix = GLKMatrix4Identity
    }

    func resize(width: Float, height: Float) {
        projectionMatrix = GLKMatrix4MakePerspective(Float.pi / 3, width / height, 0.1, 100.0)
    }
}
