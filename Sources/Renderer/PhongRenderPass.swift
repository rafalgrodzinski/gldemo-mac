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

    func draw(models: [Model], camera: Camera, lights: [Light], configs: [GLView.Config]) {
        glUseProgram(program.programId)
        camera.prepareForDraw(withProgram: program)
        lights.forEach { $0.prepareForDraw(withProgram: program) }
        for (i, model) in models.enumerated() {
            var modelMatrix = GLKMatrix4MakeTranslation(configs[i].tx, configs[i].ty, configs[i].tz)
            modelMatrix = GLKMatrix4RotateX(modelMatrix, (configs[i].rx / 180.0) * Float.pi)
            modelMatrix = GLKMatrix4RotateY(modelMatrix, (configs[i].ry / 180.0) * Float.pi)
            modelMatrix = GLKMatrix4RotateZ(modelMatrix, (configs[i].rz / 180.0) * Float.pi)

            model.draw(program: program, modelMatrix: modelMatrix)
        }
    }
}
