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
    private static let fullTurnDelta: GLfloat = 400

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
        if inputState.isMouseRight && (inputState.mouseDeltaX != 0 || inputState.mouseDeltaY != 0) {
            arcballUpdate(inputState: inputState)
        } else if inputState.isMouseLeft {
            flybyUpdate(deltaTime: deltaTime, inputState: inputState)
            //arcballUpdate(inputState: inputState)
        }
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

        /*let eyeX = position.x - sin(rotation.ry) * abs(cos(rotation.rx))
        let eyeY = position.y - sin(rotation.rx)
        let eyeZ = position.z - cos(rotation.ry) * abs(cos(rotation.rx))*/

        //viewMatrix = GLKMatrix4MakeLookAt(position.x, position.y, position.z, eyeX, eyeY, eyeZ, 0, 1, 0)

        viewMatrix = GLKMatrix4MakeXRotation(rotation.rx)
        viewMatrix = GLKMatrix4RotateY(viewMatrix, -rotation.ry)
        viewMatrix = GLKMatrix4Translate(viewMatrix, -position.x, -position.y, -position.z)
    }

    private func arcballUpdate(inputState: Input.State) {
        //let positionVector = GLKVector3(v: position)
        let originVector = GLKVector3(v: (0, 0, 1))
        let yZeroVector = GLKVector3Normalize(GLKVector3(v: (position.x, 0, position.z)))
        let xZeroVector = GLKVector3Normalize(GLKVector3(v: (0, position.y, position.z)))

        let xDot = GLKVector3DotProduct(originVector, yZeroVector)
        let yDot = GLKVector3DotProduct(originVector, xZeroVector)

        var yRad = acos(xDot)
       // let yRad: Float = -(xDot - 1)
        //let xRad = 1.0 - yDot
        /*if position.x < 0 {
            yRad *= -1
        }*/

        var xRad = acos(yDot)
        /*if position.y > 0 {
            xRad *= -1
        }*/

        //debugPrint("yRad: \(yRad), xRad: \(xRad)")

        //let newXRad = xRad + inputState.movement.y * Self.movementSpeed
        let newYRad = yRad + inputState.mouseDeltaX / Self.fullTurnDelta
        let newXRad = xRad + inputState.mouseDeltaY / Self.fullTurnDelta

        //debugPrint("xDot: \(xDot), yRad: \(yRad), newYRad: \(newYRad)")
        //debugPrint("yDot: \(xDot), xRad: \(xRad), newXRad: \(newXRad)")

        let yRot = Float.pi * inputState.mouseDeltaX / Self.fullTurnDelta
        var xRot = Float.pi * inputState.mouseDeltaY / Self.fullTurnDelta

        /*let testRot = GLKMatrix3MakeXRotation(xRot)
        let testV = GLKMatrix3MultiplyVector3(testRot, GLKVector3(v: position))
        let testD = GLKVector3DotProduct(GLKVector3(v: (0, 1, 0)), GLKVector3Normalize(testV))
        debugPrint("testD: \(testD)")
        if abs(testD) > 0.9 {
            xRot = 0
        }*/

        let len = GLKVector2Length(GLKVector2(v: (xRot, yRot)))

        let mat = GLKMatrix3MakeRotation(len, xRot / len, yRot / len, 0)
        position = GLKMatrix3MultiplyVector3(mat, GLKVector3(v: position)).v

        /*var q = GLKQuaternionIdentity
        //q = GLKQuaternionMultiply(GLKQuaternionMakeWithAngleAndAxis(yRot, 0, 1, 0), q)
        //q = GLKQuaternionMultiply(GLKQuaternionMakeWithAngleAndAxis(xRot, 1, 0, 0), q)
        q = GLKQuaternionMultiply(q, GLKQuaternionMakeWithAngleAndAxis(len, xRot/len, yRot/len, 0))
        let qm = GLKMatrix3MakeWithQuaternion(q)
        //let qm = GLKMatrix4MakeWithQuaternion(q)
        position = GLKMatrix3MultiplyVector3(qm, GLKVector3(v: position)).v*/

        //var mat = GLKMatrix3MakeYRotation(yRot)
        //mat = GLKMatrix3RotateX(mat, -xRot)
        /*var mat = GLKMatrix3MakeXRotation(-xRot)
        mat = GLKMatrix3RotateY(mat, yRot)
        debugPrint("xRot: \(xRot)")
        //var mat = GLKMatrix3MakeXRotation(-xRot)
        let newP = GLKMatrix3MultiplyVector3(mat, GLKVector3(v: position))
        position = newP.v*/

        /*viewMatrix = GLKMatrix4MakeTranslation(0, 0, -GLKVector3Length(GLKVector3(v: position)))
        viewMatrix = GLKMatrix4RotateX(viewMatrix, newXRad)
        viewMatrix = GLKMatrix4RotateY(viewMatrix, newYRad)*/



        /*var rotationMatrix = GLKMatrix3MakeYRotation(newYRad)// * Float.pi)
        rotationMatrix = GLKMatrix3RotateX(rotationMatrix, newXRad)

        let newOriginVector = GLKVector3(v: (0, 0, GLKVector3Length(GLKVector3(v: position))))

        let newRotated = GLKMatrix3MultiplyVector3(rotationMatrix, newOriginVector)


        //debugPrint("origin: \(newOriginVector.x) \(newOriginVector.y) \(newOriginVector.z), old: \(position.x) \(position.y) \(position.z), angle: \(newXRad), \(newYRad), new: \(newRotated.x) \(newRotated.y) \(newRotated.z)")
        debugPrint("origin: \(newOriginVector.x) \(newOriginVector.y) \(newOriginVector.z), old: \(position.x) \(position.y) \(position.z), angle: \(newYRad), new: \(newRotated.x) \(newRotated.y) \(newRotated.z)")
        position = (newRotated.x, newRotated.y, newRotated.z)

        //debugPrint("rx: \(newXRad), ry: \(newYRad), x: \(position.x), y: \(position.y), z: \(position.z)")

*/

        //viewMatrix = GLKMatrix4MakeLookAt(position.x, position.y, position.z, 0, 0, 0, 0, 1, 0)
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
    }
}
