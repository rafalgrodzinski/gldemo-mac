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
    private static let movementSpeed: GLfloat = 0.25
    private static let fullTurnDelta: GLfloat = 200

    enum Kind {
        case perspective(angle: Float, width: Float, height: Float, near: Float, far: Float)
    }

    private var projectionMatrix: GLKMatrix4
    private var viewMatrix: GLKMatrix4 = GLKMatrix4Identity
    private let kind: Kind
    private var position: (x: GLfloat, y: GLfloat, z: GLfloat) = (0, 0, 0)
    private var rotation: (rx: GLfloat, ry: GLfloat, rz: GLfloat) = (0, 0, 0)

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

    func update(deltaTime: TimeInterval, inputState: Input.State) {
        if inputState.isMouseRight && inputState.isMouseInView && (inputState.mouseDeltaX != 0 || inputState.mouseDeltaY != 0) {
            arcballUpdate(inputState: inputState)
        } else if inputState.isMouseLeft && inputState.isMouseInView {
            flybyUpdate(deltaTime: deltaTime, inputState: inputState)
        }

        viewMatrix = GLKMatrix4MakeXRotation(rotation.rx)
        viewMatrix = GLKMatrix4RotateY(viewMatrix, -rotation.ry)
        viewMatrix = GLKMatrix4Translate(viewMatrix, -position.x, -position.y, -position.z)
    }

    private func flybyUpdate(deltaTime: TimeInterval, inputState: Input.State) {
        if inputState.isMouseLeft {
            rotation = (
                (rotation.rx - inputState.mouseDeltaY / Self.fullTurnDelta).clamp((-Float.pi/2 + 0.01)...(Float.pi/2 - 0.01)),
                rotation.ry - inputState.mouseDeltaX / Self.fullTurnDelta,
                rotation.rz
            )
        }

        self.position = (
            position.x + inputState.movement.x * Self.movementSpeed * cos(rotation.ry) + inputState.movement.z * Self.movementSpeed * sin(rotation.ry),
            position.y + inputState.movement.y * Self.movementSpeed + inputState.movement.z * Self.movementSpeed * sin(rotation.rx),
            position.z + inputState.movement.z * Self.movementSpeed * cos(rotation.ry) * cos(rotation.rx) - inputState.movement.x * Self.movementSpeed * sin(rotation.ry) * cos(rotation.rx)
        )
    }

    private func arcballUpdate(inputState: Input.State) {
        // X Angle
        var xAngle = acos(
            GLKVector3DotProduct(
                GLKVector3Normalize(GLKVector3(v: (position.x, 0, position.z))),
                GLKVector3Normalize(GLKVector3(v: position))
            )
        )
        if position.y > 0 {
            xAngle = -xAngle
        }

        xAngle += inputState.mouseDeltaY / Self.fullTurnDelta
        if xAngle < -Float.pi/2 {
            xAngle = -Float.pi/2
        } else if xAngle > Float.pi/2 {
            xAngle = Float.pi/2
        }

        // Y Angle
        var yAngle = acos(
            GLKVector3DotProduct(
                GLKVector3(v: (0, 0, 1)),
                GLKVector3Normalize(GLKVector3(v: (position.x, 0, position.z)))
            )
        )
        if position.x < 0 {
            yAngle =  Float.pi * 2 - yAngle
        }
        yAngle -= inputState.mouseDeltaX /  Self.fullTurnDelta

        // Rotation
        rotation = (-xAngle, yAngle, rotation.rz)

        // Position
        var positionMatrix = GLKMatrix4MakeYRotation(yAngle)
        positionMatrix = GLKMatrix4RotateX(positionMatrix, xAngle)
        let originVector = GLKVector3(v: (0, 0, GLKVector3Length(GLKVector3(v: position))))
        position = GLKMatrix4MultiplyVector3(positionMatrix, originVector).v
    }

    func prepareForDraw(withProgram program: ShaderProgram) {
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
    }
}
