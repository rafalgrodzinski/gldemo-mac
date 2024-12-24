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
    }

    private static let cubeVertices = [
        // Front
        Vertex(position: (-1, -1, 1), color: (1, 0, 0)), Vertex(position: (-1, 1, 1), color: (1, 0, 0)), Vertex(position: (1, -1, 1), color: (1, 0, 0)),
        Vertex(position: (1, -1, 1), color: (1, 0, 0)), Vertex(position: (-1, 1, 1), color: (1, 0, 0)), Vertex(position: (1, 1, 1), color: (1, 0, 0)),
        // Back
        Vertex(position: (1, -1, -1), color: (0, 1, 0)), Vertex(position: (1, 1, -1), color: (0, 1, 0)), Vertex(position: (-1, 1, -1), color: (0, 1, 0)),
        Vertex(position: (1, -1, -1), color: (0, 1, 0)), Vertex(position: (-1, 1, -1), color: (0, 1, 0)), Vertex(position: (-1, -1, -1), color: (0, 1, 0)),
        // Left
        Vertex(position: (-1, -1, -1), color: (0, 0, 1)), Vertex(position: (-1, 1, -1), color: (0, 0, 1)), Vertex(position: (-1, 1, 1), color: (0, 0, 1)),
        Vertex(position: (-1, -1, -1), color: (0, 0, 1)), Vertex(position: (-1, 1, 1), color: (0, 0, 1)), Vertex(position: (-1, -1, 1), color: (0, 0, 1)),
        // Right
        Vertex(position: (1, -1, 1), color: (1, 1, 0)), Vertex(position: (1, 1, 1), color: (1, 1, 0)), Vertex(position: (1, 1, -1), color: (1, 1, 0)),
        Vertex(position: (1, -1, 1), color: (1, 1, 0)), Vertex(position: (1, 1, -1), color: (1, 1, 0)), Vertex(position: (1, -1, -1), color: (1, 1, 0)),
        // Top
        Vertex(position: (-1, 1, 1), color: (0, 1, 1)), Vertex(position: (-1, 1, -1), color: (0, 1, 1)), Vertex(position: (1, 1, -1), color: (0, 1, 1)),
        Vertex(position: (-1, 1, 1), color: (0, 1, 1)), Vertex(position: (1, 1, -1), color: (0, 1, 1)), Vertex(position: (1, 1, 1), color: (0, 1, 1)),
        // Bottom
        Vertex(position: (-1, -1, 1), color: (1, 0, 1)), Vertex(position: (1, -1, -1), color: (1, 0, 1)), Vertex(position: (-1, -1, -1), color: (1, 0, 1)),
        Vertex(position: (-1, -1, 1), color: (1, 0, 1)), Vertex(position: (1, -1, 1), color: (1, 0, 1)), Vertex(position: (1, -1, -1), color: (1, 0, 1))
    ]

    private static let pyramidVertices = [
        // Front
        Vertex(position: (1, -1, -1), color: (1, 0, 0)), Vertex(position: (0, 1, 0), color: (1, 0, 0)), Vertex(position: (-1, -1, -1), color: (1, 0, 0)),
        // Back
        Vertex(position: (-1, -1, 1), color: (0, 1, 0)), Vertex(position: (0, 1, 0), color: (0, 1, 0)), Vertex(position: (1, -1, 1), color: (0, 1, 0)),
        // Left
        Vertex(position: (-1, -1, -1), color: (0, 0, 1)), Vertex(position: (0, 1, 0), color: (0, 0, 1)), Vertex(position: (-1, -1, 1), color: (0, 0, 1)),
        // Right
        Vertex(position: (1, -1, 1), color: (1, 1, 0)), Vertex(position: (0, 1, 0), color: (1, 1, 0)), Vertex(position: (1, -1, -1), color: (1, 1, 0)),
        // Bottom
        Vertex(position: (-1, -1, 1), color: (0, 1, 1)), Vertex(position: (1, -1, -1), color: (0, 1, 1)), Vertex(position: (-1, -1, -1), color: (0, 1, 1)),
        Vertex(position: (-1, -1, 1), color: (0, 1, 1)), Vertex(position: (1, -1, 1), color: (0, 1, 1)), Vertex(position: (1, -1, -1), color: (0, 1, 1))
    ]

    enum Kind {
        case cube
        case pyramid
    }

    private let vertices: [Vertex]
    private var vertexArrayId: GLuint = 0

    init(kind: Kind) throws {
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

        glEnableVertexAttribArray(0)
        glVertexAttribPointer(
            0,
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.position)!)
        )

        glEnableVertexAttribArray(1)
        glVertexAttribPointer(
            1,
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.color)!)
        )
    }

    func draw(program: ShaderProgram, modelMatrix: GLKMatrix4) {
        let modelMatrixId = glGetUniformLocation(program.programId, "u_modelMatrix")
        modelMatrix.pointer {
            glUniformMatrix4fv(modelMatrixId, 1, GLboolean(GL_FALSE), $0)
        }

        glBindVertexArray(vertexArrayId)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, GLsizei(vertices.count))
    }
}
