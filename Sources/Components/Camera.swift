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
    enum Kind {
        case perspective(angle: Float, width: Float, height: Float, near: Float, far: Float)
    }

    private var projectionMatrix: GLKMatrix4
    private let kind: Kind

    init(kind: Kind) {
        self.kind = kind
        switch kind {
        case let .perspective(angle, width, height, near, far):
            if width <= 0 || height <= 0 {
                projectionMatrix = GLKMatrix4Identity
            } else {
                projectionMatrix = GLKMatrix4MakePerspective(angle * Float.pi / 180.0, width / height, near, far)
            }
        }
    }

    func resize(width: Float, height: Float) {
        switch kind {
        case let .perspective(angle, _, _, near, far):
            projectionMatrix = GLKMatrix4MakePerspective(angle * Float.pi / 180.0, width / height, near, far)
        }
    }

    func initFrame(program: ShaderProgram) {
        let projectionMatrixId = glGetUniformLocation(program.programId, "u_projectionMatrix")
        projectionMatrix.pointer {
            glUniformMatrix4fv(projectionMatrixId, 1, GLboolean(GL_FALSE), $0)
        }
    }
}
