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
        case directional(direction: (x: GLfloat, y: GLfloat, z: GLfloat))
    }

    let kind: Kind
    let color: (r: GLfloat, g: GLfloat, b: GLfloat)
    let intensity: GLfloat

    init(kind: Kind, color:(r: GLfloat, g: GLfloat, b: GLfloat), intensity: GLfloat) {
        self.kind = kind
        self.color = color
        self.intensity = intensity
    }

    func initFrame(program: ShaderProgram) {
        switch kind {
        case .directional(let direction):
            let directionId = glGetUniformLocation(program.programId, "u_light.direction")
            glUniform3f(directionId, direction.x, direction.y, direction.z)
        }

        let colorId = glGetUniformLocation(program.programId, "u_light.color")
        glUniform3f(colorId, color.r, color.g, color.b)

        let intensityId = glGetUniformLocation(program.programId, "u_light.intensity")
        glUniform1f(intensityId, intensity)
    }
}
