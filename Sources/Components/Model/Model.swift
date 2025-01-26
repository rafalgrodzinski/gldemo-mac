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

    private struct AnimatedVertex {
        let position: (x: Float, y: Float, z: Float)
        let nextPosition: (x: Float, y: Float, z: Float)
        let normal: (x: Float, y: Float, z: Float)
        let nextNormal: (x: Float, y: Float, z: Float)
        let material: Material
    }

    private let framesCount: Int
    private let verticesCount: Int
    private let frameDuration: TimeInterval
    private var vertexArrayId: GLuint = 0
    private var textureId: GLuint = 0
    private var currentTime: TimeInterval = 0
    private var modelMatrix: GLKMatrix4 = GLKMatrix4Identity

    var translation: (x: Float, y: Float, z: Float) = (0, 0, 0) { didSet { updateModelMatrix() }}
    var rotation: (x: Float, y: Float, z: Float) = (0, 0, 0) { didSet { updateModelMatrix() }}
    var scale: (x: Float, y: Float, z: Float) = (1, 1, 1) { didSet { updateModelMatrix() }}

    init(program: ShaderProgram, frames: [[Vertex]], frameDuration: TimeInterval, texture: Texture?) throws {
        framesCount = frames.count
        verticesCount = frames.first?.count ?? 0
        self.frameDuration = frameDuration

        var animatedVertices = [AnimatedVertex]()
        for (frameIndex, vertices) in frames.enumerated() {
            let nextFrameIndex = (frameIndex < framesCount-1) ? frameIndex+1 : 0
            for (vertexIndex, vertex) in vertices.enumerated() {
                let nextVertex: Vertex = frames[nextFrameIndex][vertexIndex]

                let animatedVertex = AnimatedVertex(
                    position: vertex.position,
                    nextPosition: nextVertex.position,
                    normal: vertex.normal,
                    nextNormal: nextVertex.normal,
                    material: vertex.material
                )
                animatedVertices.append(animatedVertex)
            }
        }

        glGenVertexArrays(1, &vertexArrayId)
        glBindVertexArray(vertexArrayId)

        var bufferId: GLuint = 0
        glGenBuffers(1, &bufferId)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), bufferId)
        glBufferData(GLenum(GL_ARRAY_BUFFER), MemoryLayout<AnimatedVertex>.size * animatedVertices.count, animatedVertices, GLenum(GL_STATIC_DRAW))

        let positionId = glGetAttribLocation(program.programId, "a_position")
        glEnableVertexAttribArray(GLuint(positionId))
        glVertexAttribPointer(
            GLuint(positionId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<AnimatedVertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<AnimatedVertex>.offset(of: \.position)!)
        )

        let nextPositionId = glGetAttribLocation(program.programId, "a_nextPosition")
        glEnableVertexAttribArray(GLuint(nextPositionId))
        glVertexAttribPointer(
            GLuint(nextPositionId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<AnimatedVertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<AnimatedVertex>.offset(of: \.nextPosition)!)
        )

        let normalId = glGetAttribLocation(program.programId, "a_normal")
        glEnableVertexAttribArray(GLuint(normalId))
        glVertexAttribPointer(
            GLuint(normalId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<AnimatedVertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<AnimatedVertex>.offset(of: \.normal)!)
        )

        let nextNormalId = glGetAttribLocation(program.programId, "a_nextNormal")
        glEnableVertexAttribArray(GLuint(nextNormalId))
        glVertexAttribPointer(
            GLuint(nextNormalId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<AnimatedVertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<AnimatedVertex>.offset(of: \.nextNormal)!)
        )

        let colorId = glGetAttribLocation(program.programId, "a_color")
        glEnableVertexAttribArray(GLuint(colorId))
        glVertexAttribPointer(
            GLuint(colorId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<AnimatedVertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<AnimatedVertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.color)!)
        )

        let coordsId = glGetAttribLocation(program.programId, "a_coords")
        glEnableVertexAttribArray(GLuint(coordsId))
        glVertexAttribPointer(
            GLuint(coordsId),
            2,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<AnimatedVertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<AnimatedVertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.coords)!)
        )

        let ambientDiffuseSpecularId = glGetAttribLocation(program.programId, "a_ambientDiffuseSpecular")
        glEnableVertexAttribArray(GLuint(ambientDiffuseSpecularId))
        glVertexAttribPointer(
            GLuint(ambientDiffuseSpecularId),
            3,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<AnimatedVertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<AnimatedVertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.ambient)!)
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

        glBindVertexArray(0)
    }

    private func updateModelMatrix() {
        //modelMatrix = GLKMatrix4MakeScale(scale.x, scale.y, scale.z)
        //modelMatrix = GLKMatrix4Translate(modelMatrix, translation.x, translation.y, translation.z)
        modelMatrix = GLKMatrix4MakeTranslation(translation.x, translation.y, translation.z)
        modelMatrix = GLKMatrix4RotateX(modelMatrix, rotation.x)
        modelMatrix = GLKMatrix4RotateY(modelMatrix, rotation.y)
        modelMatrix = GLKMatrix4RotateZ(modelMatrix, rotation.z)
        modelMatrix = GLKMatrix4Scale(modelMatrix, scale.x, scale.y, scale.z)
    }

    func update(deltaTime: TimeInterval) {
        currentTime += deltaTime
    }

    func draw(program: ShaderProgram) {
        let modelMatrixId = glGetUniformLocation(program.programId, "u_modelMatrix")
        modelMatrix.pointer {
            glUniformMatrix4fv(modelMatrixId, 1, GLboolean(GL_FALSE), $0)
        }

        var currentFrame = 0
        if framesCount > 0 && frameDuration > 0 {
            currentFrame = Int(currentTime / frameDuration) % framesCount
            let tweenFactor = modf(currentTime.float / frameDuration.float).1

            let tweenFactorId = glGetUniformLocation(program.programId, "u_tweenFactor")
            glUniform1f(tweenFactorId, tweenFactor)
        }

        glBindVertexArray(vertexArrayId)

        glActiveTexture(GLenum(GL_TEXTURE0))
        glBindTexture(GLenum(GL_TEXTURE_2D), textureId)
        let samplerId = glGetUniformLocation(program.programId, "u_sampler")
        glUniform1i(samplerId, 0)

        glDrawArrays(GLenum(GL_TRIANGLES), GLint(currentFrame * verticesCount), GLsizei(verticesCount))
    }
}
