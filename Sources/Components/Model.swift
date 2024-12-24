//
//  Model.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import OpenGL.GL
import GLKit

final class Model {
    struct Vertex {
        let position: (x: GLfloat, y: GLfloat, z: GLfloat)
        let color: (r: GLfloat, g: GLfloat, b: GLfloat)
        let coords: (u: GLfloat, v: GLfloat)
        let normal: (x: GLfloat, y: GLfloat, z: GLfloat)
    }

    private static let cubeVertices = [
        // Front
        Vertex(position: (-1, -1, 1), color: (1, 0, 0), coords: (0, 1), normal: (0, 0, 1)), Vertex(position: (-1, 1, 1), color: (1, 0, 0), coords: (1, 0), normal: (0, 0, 1)), Vertex(position: (1, -1, 1), color: (1, 0, 0), coords: (0, 0), normal: (0, 0, 1)),
        Vertex(position: (1, -1, 1), color: (1, 0, 0), coords: (0, 0), normal: (0, 0, 1)), Vertex(position: (-1, 1, 1), color: (1, 0, 0), coords: (1, 1), normal: (0, 0, 1)), Vertex(position: (1, 1, 1), color: (1, 0, 0), coords: (1, 0), normal: (0, 0, 1)),
        // Back
        Vertex(position: (1, -1, -1), color: (0, 1, 0), coords: (0, 0), normal: (0, 0, -1)), Vertex(position: (1, 1, -1), color: (0, 1, 0), coords: (0, 1), normal: (0, 0, -1)), Vertex(position: (-1, 1, -1), color: (0, 1, 0), coords: (1, 1), normal: (0, 0, -1)),
        Vertex(position: (1, -1, -1), color: (0, 1, 0), coords: (0, 0), normal: (0, 0, -1)), Vertex(position: (-1, 1, -1), color: (0, 1, 0), coords: (1, 1), normal: (0, 0, -1)), Vertex(position: (-1, -1, -1), color: (0, 1, 0), coords: (1, 0), normal: (0, 0, -1)),
        // Left
        Vertex(position: (-1, -1, -1), color: (0, 0, 1), coords: (0, 0), normal: (-1, 0, 0)), Vertex(position: (-1, 1, -1), color: (0, 0, 1), coords: (0, 1), normal: (-1, 0, 0)), Vertex(position: (-1, 1, 1), color: (0, 0, 1), coords: (1, 1), normal: (-1, 0, 0)),
        Vertex(position: (-1, -1, -1), color: (0, 0, 1), coords: (0, 0), normal: (-1, 0, 0)), Vertex(position: (-1, 1, 1), color: (0, 0, 1), coords: (1, 1), normal: (-1, 0, 0)), Vertex(position: (-1, -1, 1), color: (0, 0, 1), coords: (1, 0), normal: (-1, 0, 0)),
        // Right
        Vertex(position: (1, -1, 1), color: (1, 1, 0), coords: (0, 0), normal: (1, 0, 0)), Vertex(position: (1, 1, 1), color: (1, 1, 0), coords: (0, 1), normal: (1, 0, 0)), Vertex(position: (1, 1, -1), color: (1, 1, 0), coords: (1, 1), normal: (1, 0, 0)),
        Vertex(position: (1, -1, 1), color: (1, 1, 0), coords: (0, 0), normal: (1, 0, 0)), Vertex(position: (1, 1, -1), color: (1, 1, 0), coords: (1, 1), normal: (1, 0, 0)), Vertex(position: (1, -1, -1), color: (1, 1, 0), coords: (1, 0), normal: (1, 0, 0)),
        // Top
        Vertex(position: (-1, 1, 1), color: (0, 1, 1), coords: (0, 0), normal: (0, 1, 0)), Vertex(position: (-1, 1, -1), color: (0, 1, 1), coords: (0, 1), normal: (0, 1, 0)), Vertex(position: (1, 1, -1), color: (0, 1, 1), coords: (1, 1), normal: (0, 1, 0)),
        Vertex(position: (-1, 1, 1), color: (0, 1, 1), coords: (0, 0), normal: (0, 1, 0)), Vertex(position: (1, 1, -1), color: (0, 1, 1), coords: (1, 1), normal: (0, 1, 0)), Vertex(position: (1, 1, 1), color: (0, 1, 1), coords: (1, 0), normal: (0, 1, 0)),
        // Bottom
        Vertex(position: (-1, -1, 1), color: (1, 0, 1), coords: (0, 1), normal: (0, -1, 0)), Vertex(position: (1, -1, -1), color: (1, 0, 1), coords: (1, 0), normal: (0, -1, 0)), Vertex(position: (-1, -1, -1), color: (1, 0, 1), coords: (0, 0), normal: (0, -1, 0)),
        Vertex(position: (-1, -1, 1), color: (1, 0, 1), coords: (0, 0), normal: (0, -1, 0)), Vertex(position: (1, -1, 1), color: (1, 0, 1), coords: (1, 1), normal: (0, -1, 0)), Vertex(position: (1, -1, -1), color: (1, 0, 1), coords: (1, 0), normal: (0, -1, 0))
    ]

    private static let pyramidVertices = [
        // Front
        Vertex(position: (-1, -1, 1), color: (0, 1, 0), coords: (0, 0), normal: (0, 1, 1)), Vertex(position: (0, 1, 0), color: (0, 1, 0), coords: (0.5, 1), normal: (0, 1, 1)), Vertex(position: (1, -1, 1), color: (0, 1, 0), coords: (1, 0), normal: (0, 1, 1)),
        // Back
        Vertex(position: (1, -1, -1), color: (1, 0, 0), coords: (0, 0), normal: (0, 1, -1)), Vertex(position: (0, 1, 0), color: (1, 0, 0), coords: (0.5, 1), normal: (0, 1, -1)), Vertex(position: (-1, -1, -1), color: (1, 0, 0), coords: (1, 0), normal: (0, 1, -1)),
        // Left
        Vertex(position: (-1, -1, -1), color: (0, 0, 1), coords: (0, 0), normal: (-1, 1, 0)), Vertex(position: (0, 1, 0), color: (0, 0, 1), coords: (0.5, 1), normal: (-1, 1, 0)), Vertex(position: (-1, -1, 1), color: (0, 0, 1), coords: (1, 0), normal: (-1, 1, 0)),
        // Right
        Vertex(position: (1, -1, 1), color: (1, 1, 0), coords: (0, 0), normal: (1, 1, 0)), Vertex(position: (0, 1, 0), color: (1, 1, 0), coords: (0.5, 1), normal: (1, 1, 0)), Vertex(position: (1, -1, -1), color: (1, 1, 0), coords: (1, 0), normal: (1, 1, 0)),
        // Bottom
        Vertex(position: (-1, -1, 1), color: (0, 1, 1), coords: (0, 1), normal: (0, -1, 0)), Vertex(position: (1, -1, -1), color: (0, 1, 1), coords: (1, 0), normal: (0, -1, 0)), Vertex(position: (-1, -1, -1), color: (0, 1, 1), coords: (0, 0), normal: (0, -1, 0)),
        Vertex(position: (-1, -1, 1), color: (0, 1, 1), coords: (0, 0), normal: (0, -1, 0)), Vertex(position: (1, -1, 1), color: (0, 1, 1), coords: (1, 1), normal: (0, -1, 0)), Vertex(position: (1, -1, -1), color: (0, 1, 1), coords: (1, 0), normal: (0, -1, 0))
    ]

    enum Kind {
        case cube
        case pyramid
    }

    private let vertices: [Vertex]
    private var vertexArrayId: GLuint = 0
    private var textureId: GLuint = 0

    init(program: ShaderProgram, kind: Kind, textureBitmap: NSBitmapImageRep?) throws {
        vertices = switch (kind) {
        case .cube: Self.cubeVertices
        case .pyramid: Self.pyramidVertices
        }

        glGenVertexArrays(1, &vertexArrayId)
        glBindVertexArray(vertexArrayId)

        var bufferId: GLuint = 0
        glGenBuffers(1, &bufferId)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), bufferId)
        glBufferData(GLenum(GL_ARRAY_BUFFER), MemoryLayout<Vertex>.size * vertices.count, vertices, GLenum(GL_STATIC_DRAW))

        let positionId = glGetAttribLocation(program.programId, "a_position")
        glEnableVertexAttribArray(GLuint(positionId))
        glVertexAttribPointer(
            GLuint(positionId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.position)!)
        )

        let colorId = glGetAttribLocation(program.programId, "a_color")
        glEnableVertexAttribArray(GLuint(colorId))
        glVertexAttribPointer(
            GLuint(colorId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.color)!)
        )

        if let textureBitmap {
            let coordsId = glGetAttribLocation(program.programId, "a_coords")
            glEnableVertexAttribArray(GLuint(coordsId))
            glVertexAttribPointer(
                GLuint(coordsId),
                2,
                GLenum(GL_FLOAT),
                GLboolean(GL_FALSE),
                GLsizei(MemoryLayout<Vertex>.stride),
                UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.coords)!)
            )

            glGenTextures(1, &textureId)
            glBindTexture(GLenum(GL_TEXTURE_2D), textureId)
            glTexImage2D(
                GLenum(GL_TEXTURE_2D),
                0,
                GL_RGBA,
                GLint(textureBitmap.pixelsWide),
                GLint(textureBitmap.pixelsHigh),
                0,
                GLenum(GL_RGBA),
                GLenum(GL_UNSIGNED_BYTE),
                textureBitmap.bitmapData
            )

            glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_NEAREST)
            glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_NEAREST)

            let samplerId = glGetUniformLocation(program.programId, "u_sampler")
            glUniform1i(samplerId, 0)
        }

        let normalId = glGetAttribLocation(program.programId, "a_normal")
        glEnableVertexAttribArray(GLuint(normalId))
        glVertexAttribPointer(
            GLuint(normalId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.normal)!)
        )

        glBindVertexArray(0)
    }

    func draw(program: ShaderProgram, modelMatrix: GLKMatrix4) {
        let modelMatrixId = glGetUniformLocation(program.programId, "u_modelMatrix")
        modelMatrix.pointer {
            glUniformMatrix4fv(modelMatrixId, 1, GLboolean(GL_FALSE), $0)
        }

        glBindVertexArray(vertexArrayId)
        glBindTexture(GLenum(GL_TEXTURE_2D), textureId)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, GLsizei(vertices.count))
    }
}
