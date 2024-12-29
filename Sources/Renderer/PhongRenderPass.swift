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
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "shader", withExtension: "vsh")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "shader", withExtension: "fsh")!
        )
    }

    func initFrame() {
        glClearColor(0, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))

        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))
        glEnable(GLenum(GL_CULL_FACE))
        glFrontFace(GLenum(GL_CCW))

        glUseProgram(program.programId)
    }

    func draw(models: [Model], configs: [GLView.Config]) {
        for (i, model) in models.enumerated() {
            var modelMatrix = GLKMatrix4MakeTranslation(configs[i].tx, configs[i].ty, configs[i].tz)
            modelMatrix = GLKMatrix4RotateX(modelMatrix, (configs[i].rx / 180.0) * Float.pi)
            modelMatrix = GLKMatrix4RotateY(modelMatrix, (configs[i].ry / 180.0) * Float.pi)
            modelMatrix = GLKMatrix4RotateZ(modelMatrix, (configs[i].rz / 180.0) * Float.pi)

            model.draw(program: program, modelMatrix: modelMatrix)
        }
    }
}
