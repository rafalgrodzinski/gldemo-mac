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
    /*struct Vertex {
        let x: Float
        let y: Float
        let z: Float
    }*/

    private static let cubeVertices: [GLfloat] = [
        /*
        // Front
        Vertex(x: -1, y: -1, z: 1), Vertex(x: -1, y: 1, z: 1), Vertex(x: 1, y: -1, z: 1),
        Vertex(x: 1, y: -1, z: 1), Vertex(x: -1, y: 1, z: 1), Vertex(x: 1, y: 1, z: 1),
        // Back
        Vertex(x: 1, y: -1, z: -1), Vertex(x: 1, y: 1, z: -1), Vertex(x: -1, y: 1, z: -1),
        Vertex(x: 1, y: -1, z: -1), Vertex(x: -1, y: 1, z: -1), Vertex(x: -1, y: -1, z: -1),
        // Left
        Vertex(x: -1, y: -1, z: -1), Vertex(x: -1, y: 1, z: -1), Vertex(x: -1, y: 1, z: 1),
        Vertex(x: -1, y: -1, z: -1), Vertex(x: -1, y: 1, z: 1), Vertex(x: -1, y: -1, z: 1),
        // Right
        Vertex(x: 1, y: -1, z: 1), Vertex(x: 1, y: 1, z: 1), Vertex(x: 1, y: 1, z: -1),
        Vertex(x: 1, y: -1, z: 1), Vertex(x: 1, y: 1, z: -1), Vertex(x: 1, y: -1, z: -1),
         */
        // Front
        -1, -1, 1, -1, 1, 1, 1, -1, 1,
         1, -1, 1, -1, 1, 1, 1, 1, 1,
         // Back
         1, -1, -1, 1, 1, -1, -1, 1, -1,
         1, -1, -1, -1, 1, -1, -1, -1, -1,
         // Left
         -1, -1, -1, -1, 1, -1, -1, 1, 1,
         -1, -1, -1, -1, 1, 1, -1, -1, 1,
         // Right
         1, -1, 1, 1, 1, 1, 1, 1, -1,
         1, -1, 1, 1, 1, -1, 1, -1, -1,
         // Top
         -1, 1, 1, -1, 1, -1, 1, 1, -1,
         -1, 1, 1, 1, 1, -1, 1, 1, 1,
         // Bottom
         -1, -1, 1, 1, -1, -1, -1, -1, -1,
         -1, -1, 1, 1, -1, 1, 1, -1, -1
    ]

    private static let pyramidVertices: [GLfloat] = [
        // Front
        1, -1, -1, 0, 1, 0, -1, -1, -1,
        // Back
        -1, -1, 1, 0, 1, 0,  1, -1, 1,
        // Left
        -1, -1, -1, 0, 1, 0, -1, -1, 1,
        // Right
        1, -1, 1, 0, 1, 0, 1, -1, -1,
        // Bottom
        -1, -1, 1, 1, -1, -1, -1, -1, -1,
        -1, -1, 1, 1, -1, 1, 1, -1, -1
    ]

    enum Kind {
        case cube
        case pyramid
    }

    private var vertexArrayId: GLuint = 0
    private var verticesCount: GLsizei = 0

    init(kind: Kind) throws {
        let vertices = switch (kind) {
        case .cube: Self.cubeVertices
        case .pyramid: Self.pyramidVertices
        }

        glGenVertexArrays(1, &vertexArrayId)
        glBindVertexArray(vertexArrayId)

        var bufferId: GLuint = 0
        glGenBuffers(1, &bufferId)
        glBindBuffer(GL_ARRAY_BUFFER.glEnum, bufferId)
        glBufferData(GL_ARRAY_BUFFER.glEnum, MemoryLayout<GLfloat>.size * vertices.count, vertices, GL_STATIC_DRAW.glEnum)
        glVertexAttribPointer(0, 3, GL_FLOAT.glEnum, GL_FALSE.glBool, 0, nil)
        glEnableVertexAttribArray(0)
        verticesCount = GLsizei(vertices.count / 3)
    }

    func draw(program: ShaderProgram, modelMatrix: GLKMatrix4) {
        let modelMatrixId = glGetUniformLocation(program.programId, "u_modelMatrix")
        modelMatrix.pointer {
            glUniformMatrix4fv(modelMatrixId, 1, GL_FALSE.glBool, $0)
        }

        glBindVertexArray(vertexArrayId)
        glDrawArrays(GL_TRIANGLES.glEnum, 0, verticesCount)
    }
}
