//
//  GridRenderPass.swift
//  glDemo
//
//  Created by Rafał on 2025/01/25.
//


import Foundation
import OpenGL.GL

final class GridRenderPass {
    private static let vertices: [Float] = [
        -1, 0, 1,
         -1, 0, -1,
         1, 0, -1,
         1, 0, 1
    ]
    private static let indices: [UInt32] = [
        0, 1, 2,
        0, 2, 3
    ]

    private let program: ShaderProgram
    private var vertexArrayId: GLuint = 0
    private var textureId: GLuint = 0

    init() throws {
        program = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "GridShaderVertex", withExtension: "glsl")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "GridShaderFragment", withExtension: "glsl")!
        )

        let texture = try Texture(imageName: "Grid.png")

        glGenVertexArrays(1, &vertexArrayId)
        glBindVertexArray(vertexArrayId)

        var verticesBufferId: GLuint = 0
        glGenBuffers(1, &verticesBufferId)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), verticesBufferId)
        glBufferData(GLenum(GL_ARRAY_BUFFER), MemoryLayout<Float>.size * Self.vertices.count, Self.vertices, GLenum(GL_STATIC_DRAW))

        var indicesBufferId: GLuint = 0
        glGenBuffers(1, &indicesBufferId)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indicesBufferId)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), MemoryLayout<UInt32>.size * Self.indices.count, Self.indices, GLenum(GL_STATIC_DRAW))

        let positionId = glGetAttribLocation(program.programId, "a_position")
        glEnableVertexAttribArray(GLuint(positionId))
        glVertexAttribPointer(GLuint(positionId), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Float>.size * 3), nil)

        // Texture
        glGenTextures(1, &textureId)
        glBindTexture(GLenum(GL_TEXTURE_2D), textureId)
        glTexImage2D(
            GLenum(GL_TEXTURE_2D),
            0,
            GL_RGBA,
            GLint(texture.width),
            GLint(texture.height),
            0,
            texture.pixelFormat,
            GLenum(GL_UNSIGNED_BYTE),
            texture.dataPointer
        )
        glGenerateMipmap(GLenum(GL_TEXTURE_2D))
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR_MIPMAP_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR_MIPMAP_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAX_ANISOTROPY_EXT), 8)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GL_REPEAT)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GL_REPEAT)

        glBindTexture(GLenum(GL_TEXTURE_2D), 0)
        glBindVertexArray(0)
    }

    func draw(camera: Camera) {
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))

        glUseProgram(program.programId)
        camera.prepareForDraw(withProgram: program)

        glBindVertexArray(vertexArrayId)

        glActiveTexture(GLenum(GL_TEXTURE0))
        glBindTexture(GLenum(GL_TEXTURE_2D), textureId)
        let samplerId = glGetUniformLocation(program.programId, "u_sampler")
        glUniform1i(samplerId, 0)

        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(Self.indices.count), GLenum(GL_UNSIGNED_INT), nil)

        glDisable(GLenum(GL_BLEND))
    }
}
