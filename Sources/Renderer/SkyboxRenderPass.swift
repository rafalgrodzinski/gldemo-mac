//
//  SkyboxRenderPass.swift
//  glDemo
//
//  Created by Rafał on 2025/01/28.
//

import Foundation
import OpenGL.GL

final class SkyboxRenderPass {
    private let program: ShaderProgram
    private let model: Model

    init() throws {
        program = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "SkyboxVertex", withExtension: "glsl")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "SkyboxFragment", withExtension: "glsl")!
        )

        let textureCube: (left: Texture, right: Texture, front: Texture, back: Texture, bottom: Texture, top: Texture) = (
            left: try Texture(imageName: "skybox_left"),
            right: try Texture(imageName: "skybox_right"),
            front: try Texture(imageName: "skybox_back"),
            back: try Texture(imageName: "skybox_front"),
            bottom: try Texture(imageName: "skybox_bottom"),
            top: try Texture(imageName: "skybox_top")
        )

        model = try Model.init(program: program, kind: .cube, textureCube: textureCube)
    }

    func draw(camera: Camera) {
        glDisable(GLenum(GL_DEPTH_TEST))
        glDepthMask(GLboolean(GL_FALSE))

        glUseProgram(program.programId)
        camera.prepareForDraw(withProgram: program)
        model.draw(program: program)
    }
}
