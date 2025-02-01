//
//  Entity.swift
//  glDemo
//
//  Created by Rafał on 2025/02/01.
//

import Foundation
import GLKit

protocol Entity: AnyObject {
    var parent: Entity? { get set }

    var translation: (x: Float, y: Float, z: Float) { get set }
    var rotation: (x: Float, y: Float, z: Float) { get set }
    var scale: (x: Float, y: Float, z: Float) { get set }
    var modelMatrix: GLKMatrix4 { get }

    func update(withDeltaTime deltaTime: TimeInterval)
    func prepareForDraw(withProgram program: ShaderProgram)
    func draw(withProgram program: ShaderProgram)
}

extension Entity {
    var modelMatrix: GLKMatrix4 {
        var modelMatrix = GLKMatrix4MakeTranslation(translation.x, translation.y, translation.z)
        modelMatrix = GLKMatrix4RotateX(modelMatrix, rotation.x)
        modelMatrix = GLKMatrix4RotateY(modelMatrix, rotation.y)
        modelMatrix = GLKMatrix4RotateZ(modelMatrix, rotation.z)
        modelMatrix = GLKMatrix4Scale(modelMatrix, scale.x, scale.y, scale.z)

        if let parentModelMatrix = parent?.modelMatrix {
            modelMatrix = GLKMatrix4Multiply(modelMatrix, parentModelMatrix)
        }

        return modelMatrix
    }
}
