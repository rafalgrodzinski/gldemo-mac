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
    struct Material {
        let color: (r: Float, g: Float, b: Float)
        let coords: (u: Float, v: Float)
        let ambient: Float
        let diffuse: Float
        let specular: Float
    }

    struct Vertex {
        let position: (x: Float, y: Float, z: Float)
        let normal: (x: Float, y: Float, z: Float)
        let material: Material
    }

    private let verticesCount: Int
    private var vertexArrayId: GLuint = 0
    private var textureId: GLuint = 0

    init(program: ShaderProgram, vertices: [Vertex], texture: Texture?) throws {
        verticesCount = vertices.count

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

        let colorId = glGetAttribLocation(program.programId, "a_color")
        glEnableVertexAttribArray(GLuint(colorId))
        glVertexAttribPointer(
            GLuint(colorId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.color)!)
        )

        let coordsId = glGetAttribLocation(program.programId, "a_coords")
        glEnableVertexAttribArray(GLuint(coordsId))
        glVertexAttribPointer(
            GLuint(coordsId),
            2,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.coords)!)
        )

        let ambientDiffuseSpecularId = glGetAttribLocation(program.programId, "a_ambientDiffuseSpecular")
        glEnableVertexAttribArray(GLuint(ambientDiffuseSpecularId))
        glVertexAttribPointer(
            GLuint(ambientDiffuseSpecularId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.ambient)!)
        )

        glGenTextures(1, &textureId)
        glBindTexture(GLenum(GL_TEXTURE_2D), textureId)
        let texture = texture ?? Texture.whitePixel
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
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR)

        let samplerId = glGetUniformLocation(program.programId, "u_sampler")
        glUniform1i(samplerId, 0)

        glBindVertexArray(0)
    }

    func draw(program: ShaderProgram, modelMatrix: GLKMatrix4) {
        let modelMatrixId = glGetUniformLocation(program.programId, "u_modelMatrix")
        modelMatrix.pointer {
            glUniformMatrix4fv(modelMatrixId, 1, GLboolean(GL_FALSE), $0)
        }

        glBindVertexArray(vertexArrayId)
        glBindTexture(GLenum(GL_TEXTURE_2D), textureId)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, GLsizei(verticesCount))
    }
}
