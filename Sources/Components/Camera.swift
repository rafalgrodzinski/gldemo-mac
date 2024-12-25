//
//  Camera.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import OpenGL.GL
import GLKit
import GameController

final class Camera {
    enum Kind {
        case perspective(angle: Float, width: Float, height: Float, near: Float, far: Float)
    }

    private var projectionMatrix: GLKMatrix4
    private var viewMatrix: GLKMatrix4 = GLKMatrix4Identity
    private let kind: Kind

    private var position: (x: GLfloat, y: GLfloat, z: GLfloat) = (0, 0, 0)
    private var isForward = false
    private var isBackward = false
    private var isLeft = false
    private var isRight = false
    private var isUp = false
    private var isDown = false

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

        NotificationCenter.default.addObserver(forName: .GCKeyboardDidConnect, object: nil, queue: nil) { notification in
            let keyboard = notification.object as? GCKeyboard
            keyboard?.keyboardInput?.keyChangedHandler = { [weak self] _, _, keyCode, isPressed in
                if keyCode == .keyW { self?.isForward = isPressed }
                if keyCode == .keyS { self?.isBackward = isPressed }
                if keyCode == .keyA { self?.isLeft = isPressed }
                if keyCode == .keyD { self?.isRight = isPressed }
                if keyCode == .keyQ { self?.isDown = isPressed }
                if keyCode == .keyE { self?.isUp = isPressed }
            }
        }
    }

    func resize(width: Float, height: Float) {
        switch kind {
        case let .perspective(angle, _, _, near, far):
            projectionMatrix = GLKMatrix4MakePerspective(angle * Float.pi / 180.0, width / height, near, far)
        }
    }

    func update(deltaTime: TimeInterval) {
        let speed: GLfloat = 0.25
        var positionDelta: (x: GLfloat, y: GLfloat, z: GLfloat) = (0, 0, 0)
        if isForward { positionDelta.z -= 1.0 }
        if isBackward { positionDelta.z += 1.0 }
        if isLeft { positionDelta.x -= 1.0 }
        if isRight { positionDelta.x += 1.0 }
        if isUp { positionDelta.y += 1.0 }
        if isDown { positionDelta.y -= 1.0 }

        self.position = (position.x + positionDelta.x * speed, position.y + positionDelta.y * speed, position.z + positionDelta.z * speed)
        viewMatrix = GLKMatrix4Invert(GLKMatrix4MakeTranslation(position.x, position.y, position.z), nil)
    }

    func initFrame(program: ShaderProgram) {
        let projectionMatrixId = glGetUniformLocation(program.programId, "u_projectionMatrix")
        projectionMatrix.pointer {
            glUniformMatrix4fv(projectionMatrixId, 1, GLboolean(GL_FALSE), $0)
        }

        let viewMatrixId = glGetUniformLocation(program.programId, "u_viewMatrix")
        viewMatrix.pointer {
            glUniformMatrix4fv(viewMatrixId, 1, GLboolean(GL_FALSE), $0)
        }

        let cameraPositionId = glGetUniformLocation(program.programId, "u_cameraPosition")
        glUniform3f(cameraPositionId, position.x, position.y, position.z)
        /*viewMatrix.pointer {
            glUniformMatrix4fv(viewMatrixId, 1, GLboolean(GL_FALSE), $0)
        }*/
    }
}
