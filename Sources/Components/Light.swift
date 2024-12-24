//
//  Light.swift
//  glDemo
//
//  Created by Rafal on 24/12/2024.
//

import Foundation
import OpenGL.GL

final class Light {
    let direction: (x: GLfloat, y: GLfloat, z: GLfloat)
    let color: (r: GLfloat, g: GLfloat, b: GLfloat)
    let ambientIntensity: GLfloat
    let diffuseIntensity: GLfloat

    init(direction: (x: GLfloat, y: GLfloat, z: GLfloat), color:(r: GLfloat, g: GLfloat, b: GLfloat), ambientIntensity: GLfloat, diffuseIntensity: GLfloat) {
        self.direction = direction
        self.color = color
        self.ambientIntensity = ambientIntensity
        self.diffuseIntensity = diffuseIntensity
    }

    func update(program: ShaderProgram) {
        let directionId = glGetUniformLocation(program.programId, "u_light.direction")
        glUniform3f(directionId, direction.x, direction.y, direction.z)

        let colorId = glGetUniformLocation(program.programId, "u_light.color")
        glUniform3f(colorId, color.r, color.g, color.b)

        let ambientIntensityId = glGetUniformLocation(program.programId, "u_light.ambientIntensity");
        glUniform1f(ambientIntensityId, ambientIntensity)

        let diffuseIntensityId = glGetUniformLocation(program.programId, "u_light.diffuseIntensity");
        glUniform1f(diffuseIntensityId, diffuseIntensity)
    }
}
