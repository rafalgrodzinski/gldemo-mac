//
//  DebugRenderPass.swift
//  glDemo
//
//  Created by Rafał on 2025/01/01.
//

import Foundation
import OpenGL.GL
import GLKit

final class DebugRenderPass: RenderPass {
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

    func draw(entities: [Entity], camera: Camera) {
        glDepthMask(GLboolean(GL_TRUE))
        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))

        if isNormalsOn {
            glUseProgram(debugNormalsProgram.programId)
            camera.prepareForDraw(withProgram: debugNormalsProgram)
            entities.forEach { $0.draw(withProgram: debugNormalsProgram) }
        }

        if isMeshOn {
            glUseProgram(debugPolygonProgram.programId)
            camera.prepareForDraw(withProgram: debugPolygonProgram)
            entities.forEach { $0.draw(withProgram: debugPolygonProgram) }
        }
    }
}
