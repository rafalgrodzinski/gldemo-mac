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
    //let direction: (x: GLfloat, y: GLfloat, z: GLfloat)
    //let ambientIntensity: GLfloat
    //let diffuseIntensity: GLfloat
    //let specularIntensity: GLfloat

    /*init(direction: (x: GLfloat, y: GLfloat, z: GLfloat), color:(r: GLfloat, g: GLfloat, b: GLfloat), ambientIntensity: GLfloat, diffuseIntensity: GLfloat, specularIntensity: GLfloat) {
        self.direction = direction
        self.color = color
        self.ambientIntensity = ambientIntensity
        self.diffuseIntensity = diffuseIntensity
        self.specularIntensity = specularIntensity
    }*/
    init(kind: Kind, color:(r: GLfloat, g: GLfloat, b: GLfloat), intensity: GLfloat) {
        self.kind = kind
        self.color = color
        self.intensity = intensity
    }

    func update(program: ShaderProgram) {
        switch kind {
        case .directional(let direction):
            let directionId = glGetUniformLocation(program.programId, "u_light.direction")
            glUniform3f(directionId, direction.x, direction.y, direction.z)
        }

        let colorId = glGetUniformLocation(program.programId, "u_light.color")
        glUniform3f(colorId, color.r, color.g, color.b)

        let intensityId = glGetUniformLocation(program.programId, "u_light.intensity")
        glUniform1f(intensityId, intensity)

        /*let ambientIntensityId = glGetUniformLocation(program.programId, "u_light.ambientIntensity")
        glUniform1f(ambientIntensityId, ambientIntensity)

        let diffuseIntensityId = glGetUniformLocation(program.programId, "u_light.diffuseIntensity")
        glUniform1f(diffuseIntensityId, diffuseIntensity)

        let specularIntensityId = glGetUniformLocation(program.programId, "u_light.specularIntensity")
        glUniform1f(specularIntensityId, specularIntensity)*/
    }
}
