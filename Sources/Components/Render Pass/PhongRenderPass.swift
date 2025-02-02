//
//  PhongRenderPass.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import OpenGL.GL
import GLKit

final class PhongRenderPass: RenderPass {
    let program: ShaderProgram

    init() throws {
        program = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "PhongShader", withExtension: "vsh")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "PhongShader", withExtension: "fsh")!
        )
    }

    func draw(entities: [Entity], camera: Camera) {
        glDepthMask(GLboolean(GL_TRUE))
        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))

        glUseProgram(program.programId)
        camera.prepareForDraw(withProgram: program)
        entities.forEach { $0.prepareForDraw(withProgram: program) }
        entities.forEach { $0.draw(withProgram: program) }
    }
}
