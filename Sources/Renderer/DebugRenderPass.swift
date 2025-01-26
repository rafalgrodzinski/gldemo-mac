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

    var shouldShowMesh: Bool = false
    var shouldShowNormals: Bool = false

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
        if shouldShowMesh {
            glUseProgram(debugPolygonProgram.programId)
            camera.prepareForDraw(withProgram: debugPolygonProgram)
            models.forEach { $0.draw(program: debugPolygonProgram) }
        }

        if shouldShowNormals {
            glUseProgram(debugNormalsProgram.programId)
            camera.prepareForDraw(withProgram: debugNormalsProgram)
            models.forEach { $0.draw(program: debugNormalsProgram) }
        }
    }
}
