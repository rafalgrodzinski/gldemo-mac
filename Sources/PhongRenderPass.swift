//
//  PhongRenderPass.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import OpenGL.GL

final class PhongRenderPass: RenderPass {
    private let program: ShaderProgram

    init() throws {
        program = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "shader", withExtension: "vsh")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "shader", withExtension: "fsh")!
        )
    }

    func initFrame() {
        glUseProgram(program.program)
    }
}
