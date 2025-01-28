//
//  PhongRenderPass.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import OpenGL.GL
import GLKit

final class PhongRenderPass {
    let program: ShaderProgram

    init() throws {
        program = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "PhongShader", withExtension: "vsh")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "PhongShader", withExtension: "fsh")!
        )
    }

    func draw(models: [Model], camera: Camera, lights: [Light]) {
        glDepthMask(GLboolean(GL_TRUE))
        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))

        glUseProgram(program.programId)
        camera.prepareForDraw(withProgram: program)
        lights.forEach { $0.prepareForDraw(withProgram: program) }
        models.forEach { $0.draw(program: program) }
    }
}
