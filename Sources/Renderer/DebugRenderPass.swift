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

    func draw(models: [Model], camera: Camera, lights: [Light], configs: [GLView.Config]) {
        if shouldShowMesh {
            glUseProgram(debugPolygonProgram.programId)
            camera.prepareForDraw(withProgram: debugPolygonProgram)
            for (i, model) in models.enumerated() {
                var modelMatrix = GLKMatrix4MakeTranslation(configs[i].tx, configs[i].ty, configs[i].tz)
                modelMatrix = GLKMatrix4RotateX(modelMatrix, (configs[i].rx / 180.0) * Float.pi)
                modelMatrix = GLKMatrix4RotateY(modelMatrix, (configs[i].ry / 180.0) * Float.pi)
                modelMatrix = GLKMatrix4RotateZ(modelMatrix, (configs[i].rz / 180.0) * Float.pi)

                model.draw(program: debugPolygonProgram, modelMatrix: modelMatrix)
            }
        }

        if shouldShowNormals {
            glUseProgram(debugNormalsProgram.programId)
            camera.prepareForDraw(withProgram: debugNormalsProgram)
            for (i, model) in models.enumerated() {
                var modelMatrix = GLKMatrix4MakeTranslation(configs[i].tx, configs[i].ty, configs[i].tz)
                modelMatrix = GLKMatrix4RotateX(modelMatrix, (configs[i].rx / 180.0) * Float.pi)
                modelMatrix = GLKMatrix4RotateY(modelMatrix, (configs[i].ry / 180.0) * Float.pi)
                modelMatrix = GLKMatrix4RotateZ(modelMatrix, (configs[i].rz / 180.0) * Float.pi)

                model.draw(program: debugNormalsProgram, modelMatrix: modelMatrix)
            }
        }
    }
}
