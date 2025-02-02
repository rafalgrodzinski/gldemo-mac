//
//  GridRenderPass.swift
//  glDemo
//
//  Created by Rafał on 2025/01/25.
//


import Foundation
import OpenGL.GL

final class GridRenderPass: RenderPass {
    private static let gridVertices: [Float] = [
        -1, 0, 1,
         -1, 0, -1,
         1, 0, -1,
         1, 0, 1
    ]
    private static let gridIndices: [UInt32] = [
        0, 1, 2,
        0, 2, 3
    ]

    private static let axesVertices: [Float] = [
        0, 0, 0,
        1, 0, 0,
        0, 0, 0,
        0, 1, 0,
        0, 0, 0,
        0, 0, 1
    ]

    private let gridProgram: ShaderProgram
    private var gridVertexArrayId: GLuint = 0
    private var textureId: GLuint = 0

    private let axisProgram: ShaderProgram
    private var axisVertexArrayId: GLuint = 0

    var isGridOn = false
    var isAxesOn = false

    init() throws {
        // Grid
        gridProgram = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "GridShaderVertex", withExtension: "glsl")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "GridShaderFragment", withExtension: "glsl")!
        )

        let texture = try Texture(imageName: "Grid.png")

        glGenVertexArrays(1, &gridVertexArrayId)
        glBindVertexArray(gridVertexArrayId)

        var gridVerticesBufferId: GLuint = 0
        glGenBuffers(1, &gridVerticesBufferId)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), gridVerticesBufferId)
        glBufferData(GLenum(GL_ARRAY_BUFFER), MemoryLayout<Float>.size * Self.gridVertices.count, Self.gridVertices, GLenum(GL_STATIC_DRAW))

        var gridIndicesBufferId: GLuint = 0
        glGenBuffers(1, &gridIndicesBufferId)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), gridIndicesBufferId)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), MemoryLayout<UInt32>.size * Self.gridIndices.count, Self.gridIndices, GLenum(GL_STATIC_DRAW))

        let gridPositionId = glGetAttribLocation(gridProgram.programId, "a_position")
        glEnableVertexAttribArray(GLuint(gridPositionId))
        glVertexAttribPointer(GLuint(gridPositionId), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Float>.size * 3), nil)

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

        // Axes
        axisProgram = try ShaderProgram(
            vertexShaderFilePathUrl: Bundle.main.url(forResource: "AxisShaderVertex", withExtension: "glsl")!,
            fragmentShaderFilePathUrl: Bundle.main.url(forResource: "AxisShaderFragment", withExtension: "glsl")!
        )

        glGenVertexArrays(1, &axisVertexArrayId)
        glBindVertexArray(axisVertexArrayId)

        var axesVerticesBufferId: GLuint = 0
        glGenBuffers(1, &axesVerticesBufferId)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), axesVerticesBufferId)
        glBufferData(GLenum(GL_ARRAY_BUFFER), MemoryLayout<Float>.size * Self.axesVertices.count, Self.axesVertices, GLenum(GL_STATIC_DRAW))

        let axisPositionId = glGetAttribLocation(axisProgram.programId, "a_position")
        glEnableVertexAttribArray(GLuint(axisPositionId))
        glVertexAttribPointer(GLuint(axisPositionId), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Float>.size * 3), nil)

        glBindTexture(GLenum(GL_TEXTURE_2D), 0)
        glBindVertexArray(0)
    }

    func draw(entities: [Entity], camera: Camera) {
        glDepthMask(GLboolean(GL_TRUE))
        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))

        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        glEnable(GLenum(GL_LINE_SMOOTH))

        // Grid
        if isGridOn {
            glUseProgram(gridProgram.programId)
            camera.prepareForDraw(withProgram: gridProgram)

            glBindVertexArray(gridVertexArrayId)

            glActiveTexture(GLenum(GL_TEXTURE0))
            glBindTexture(GLenum(GL_TEXTURE_2D), textureId)
            let samplerId = glGetUniformLocation(gridProgram.programId, "u_sampler")
            glUniform1i(samplerId, 0)

            glDrawElements(GLenum(GL_TRIANGLES), GLsizei(Self.gridIndices.count), GLenum(GL_UNSIGNED_INT), nil)
        }

        // Axes
        if isAxesOn {
            glUseProgram(axisProgram.programId)
            camera.prepareForDraw(withProgram: axisProgram)
            
            glBindVertexArray(axisVertexArrayId)
            glLineWidth(2)
            
            let axisDirectionId = glGetUniformLocation(axisProgram.programId, "u_axisDirection")
            // X
            glUniform1i(axisDirectionId, 0)
            glDrawArrays(GLenum(GL_LINES), 0, 2)
            // Y
            glUniform1i(axisDirectionId, 1)
            glDrawArrays(GLenum(GL_LINES), 2, 2)
            // Z
            glUniform1i(axisDirectionId, 2)
            glDrawArrays(GLenum(GL_LINES), 4, 2)
        }
    }
}
