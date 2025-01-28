//
//  DebugRenderPass.swift
//  glDemo
//
//  Created by Rafał on 2025/01/01.
//

import Foundation
import OpenGL.GL
import GLKit

final class DebugRenderPass {
    private let debugNormalsProgram: ShaderProgram
    private let debugPolygonProgram: ShaderProgram

    var isNormalsOn: Bool = false
    var isMeshOn: Bool = false

    init() throws {
        debugNormalsProgram = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "DebugNormalsShader", withExtension: "vsh")!,
            geometryShaderFilePathUrl: Bundle.main.url(forResource: "DebugNormalsShader", withExtension: "gsh")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "DebugNormalsShader", withExtension: "fsh")!
        )

        debugPolygonProgram = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "DebugPolygonShader", withExtension: "vsh")!,
            geometryShaderFilePathUrl: Bundle.main.url(forResource: "DebugPolygonShader", withExtension: "gsh")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "DebugPolygonShader", withExtension: "fsh")!
        )
    }

    func draw(models: [Model], camera: Camera) {
        glDepthMask(GLboolean(GL_TRUE))
        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))

        if isNormalsOn {
            glUseProgram(debugNormalsProgram.programId)
            camera.prepareForDraw(withProgram: debugNormalsProgram)
            models.forEach { $0.draw(program: debugNormalsProgram) }
        }

        if isMeshOn {
            glUseProgram(debugPolygonProgram.programId)
            camera.prepareForDraw(withProgram: debugPolygonProgram)
            models.forEach { $0.draw(program: debugPolygonProgram) }
        }
    }
}
