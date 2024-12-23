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
    private let program: ShaderProgram

    init() throws {
        program = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "shader", withExtension: "vsh")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "shader", withExtension: "fsh")!
        )
        var vao: [GLuint] = [0]
        glGenVertexArrays(1, &vao)
        glBindVertexArray(vao[0])
    }

    func initFrame(withCamera camera: Camera) {
        glUseProgram(program.programId)

        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))
        glEnable(GLenum(GL_CULL_FACE))
        glFrontFace(GLenum(GL_CW))

        let projectionMatrixId = glGetUniformLocation(program.programId, "u_projectionMatrix")
        camera.projectionMatrix.pointer {
            glUniformMatrix4fv(projectionMatrixId, 1, GL_FALSE.glBool, $0)
        }
    }

    func draw(models: [Model], config: GLView.Config) {
        var modelMatrix = GLKMatrix4MakeTranslation(config.tx, config.ty, config.tz)
        modelMatrix = GLKMatrix4RotateX(modelMatrix, (config.rx / 180.0) * Float.pi)
        modelMatrix = GLKMatrix4RotateY(modelMatrix, (config.ry / 180.0) * Float.pi)
        modelMatrix = GLKMatrix4RotateZ(modelMatrix, (config.rz / 180.0) * Float.pi)

        for model in models {
            model.draw(program: program, modelMatrix: modelMatrix)
        }
    }
}
