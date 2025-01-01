//
//  Light.swift
//  glDemo
//
//  Created by Rafal on 24/12/2024.
//

import Foundation
import OpenGL.GL

final class Light {
    enum Kind {
        case directional(direction: (x: Float, y: Float, z: Float), intensity: Float)
        case point(position: (x: Float, y: Float, z: Float), linearAttenuation: Float, quadraticAttenuation: Float)
    }

    static let lightsMaxCount = 8
    static var lightsCount = 0

    private let lightIndex: Int
    let kind: Kind
    let color: (r: GLfloat, g: GLfloat, b: GLfloat)

    init(kind: Kind, color:(r: GLfloat, g: GLfloat, b: GLfloat)) throws {
        guard Self.lightsCount < Self.lightsMaxCount else { throw AppError(description: "Max lights exceeded") }
        lightIndex = Self.lightsCount
        Self.lightsCount += 1

        self.kind = kind
        self.color = color
    }

    func initFrame(program: ShaderProgram) {
        let idPrefix = "u_lights[\(lightIndex)]."

        let kindId = glGetUniformLocation(program.programId, idPrefix + "kind")
        switch kind {
        case let .directional(direction, intensity):
            glUniform1i(kindId, 1)

            let directionId = glGetUniformLocation(program.programId, idPrefix + "direction")
            glUniform3f(directionId, direction.x, direction.y, direction.z)

            let intensityId = glGetUniformLocation(program.programId, idPrefix + "intensity")
            glUniform1f(intensityId, intensity)
        case let .point(position, linear, quadratic):
            glUniform1i(kindId, 2)

            let positionId = glGetUniformLocation(program.programId, idPrefix + "position")
            glUniform3f(positionId, position.x, position.y, position.z)

            let linearAttenuationId = glGetUniformLocation(program.programId, idPrefix + "linearAttenuation")
            glUniform1f(linearAttenuationId, linear)

            let quadraticAttenuationId = glGetUniformLocation(program.programId, idPrefix + "quadraticAttenuation")
            glUniform1f(quadraticAttenuationId, quadratic)
        }

        let colorId = glGetUniformLocation(program.programId, idPrefix + "color")
        glUniform3f(colorId, color.r, color.g, color.b)
    }
}
