//
//  File.swift
//  glDemo
//
//  Created by Rafał on 2025/01/03.
//

import Foundation
import OpenGL.GL

final class GridRenderPass {
    private static let vertices: [Float] = [
        -1, 0, -1,
         1, 0, -1,
         1, 0, 1,
         -1, 0, 1
    ]
    private static let indices: [UInt32] = [0, 2, 1, 2, 0, 3]

    private let program: ShaderProgram
    private var vertexArrayId: GLuint = 0

    init() throws {
        program = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "GridShader", withExtension: "vsh")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "GridShader", withExtension: "fsh")!
        )

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

        glBindVertexArray(0)
    }

    func draw(camera: Camera) {
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))

        glUseProgram(program.programId)
        camera.prepareForDraw(withProgram: program)

        glBindVertexArray(vertexArrayId)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(Self.indices.count), GLenum(GL_UNSIGNED_INT), nil)
    }
}
