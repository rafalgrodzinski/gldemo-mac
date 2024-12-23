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

    enum Kind {
        case cube
    }

    private var vertexBufferId: GLuint = 0
    private var verticesCount: GLsizei = 0

    init(kind: Kind) throws {
        let vertices = switch (kind) {
        case .cube: Self.cubeVertices
        }
        glGenBuffers(1, &vertexBufferId)
        glBindBuffer(GL_ARRAY_BUFFER.glEnum, vertexBufferId)
        glBufferData(GL_ARRAY_BUFFER.glEnum, MemoryLayout<GLfloat>.size * vertices.count, vertices, GL_STATIC_DRAW.glEnum)
        verticesCount = GLsizei(vertices.count / 3)
    }

    func draw(program: ShaderProgram, modelMatrix: GLKMatrix4) {
        let modelMatrixId = glGetUniformLocation(program.programId, "u_modelMatrix")
        modelMatrix.pointer {
            glUniformMatrix4fv(modelMatrixId, 1, GL_FALSE.glBool, $0)
        }

        glBindBuffer(GL_ARRAY_BUFFER.glEnum, vertexBufferId)
        glVertexAttribPointer(0, 3, GL_FLOAT.glEnum, GL_FALSE.glBool, 0, nil)
        glEnableVertexAttribArray(0)

        glDrawArrays(GL_TRIANGLES.glEnum, 0, verticesCount)
    }
}
