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
        let color: (r: GLfloat, g: GLfloat, b: GLfloat)
        let coords: (u: GLfloat, v: GLfloat)
        let ambient: GLfloat
        let diffuse: GLfloat
        let specular: GLfloat
    }

    struct Vertex {
        let position: (x: GLfloat, y: GLfloat, z: GLfloat)
        let normal: (x: GLfloat, y: GLfloat, z: GLfloat)
        let material: Material
    }

    private static let cubeVertices = [
        // Front
        Vertex(position: (-1, -1, 1), normal: (0, 0, 1), material: Material(color: (1, 0, 0), coords: (0, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, 1), normal: (0, 0, 1), material: Material(color: (1, 0, 0), coords: (1, 10), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, 1), normal: (0, 0, 1), material: Material(color: (1, 0, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, 1), normal: (0, 0, 1), material: Material(color: (1, 0, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, 1), normal: (0, 0, 1), material: Material(color: (1, 0, 0), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, 1, 1), normal: (0, 0, 1), material: Material(color: (1, 0, 0), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Back
        Vertex(position: (1, -1, -1), normal: (0, 0, -1), material: Material(color: (0, 1, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, 1, -1), normal: (0, 0, -1), material: Material(color: (0, 1, 0), coords: (0, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, -1), normal: (0, 0, -1), material: Material(color: (0, 1, 0), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, -1), normal: (0, 0, -1), material: Material(color: (0, 1, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, -1), normal: (0, 0, -1), material: Material(color: (0, 1, 0), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, -1), normal: (0, 0, -1), material: Material(color: (0, 1, 0), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Left
        Vertex(position: (-1, -1, -1), normal: (-1, 0, 0), material: Material(color: (0, 0, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, -1), normal: (-1, 0, 0), material: Material(color: (0, 0, 1), coords: (0, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, 1), normal: (-1, 0, 0), material: Material(color: (0, 0, 1), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, -1), normal: (-1, 0, 0), material: Material(color: (0, 0, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, 1), normal: (-1, 0, 0), material: Material(color: (0, 0, 1), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, 1), normal: (-1, 0, 0), material: Material(color: (0, 0, 1), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Right
        Vertex(position: (1, -1, 1), normal: (1, 0, 0), material: Material(color: (1, 1, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, 1, 1), normal: (1, 0, 0), material: Material(color: (1, 1, 0), coords: (0, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, 1, -1), normal: (1, 0, 0), material: Material(color: (1, 1, 0), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, 1), normal: (1, 0, 0), material: Material(color: (1, 1, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, 1, -1), normal: (1, 0, 0), material: Material(color: (1, 1, 0), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, -1), normal: (1, 0, 0), material: Material(color: (1, 1, 0), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Top
        Vertex(position: (-1, 1, 1), normal: (0, 1, 0), material: Material(color: (0, 1, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, -1), normal: (0, 1, 0), material: Material(color: (0, 1, 1), coords: (0, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, 1, -1), normal: (0, 1, 0), material: Material(color: (0, 1, 1), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, 1, 1), normal: (0, 1, 0), material: Material(color: (0, 1, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, 1, -1), normal: (0, 1, 0), material: Material(color: (0, 1, 1), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, 1, 1), normal: (0, 1, 0), material: Material(color: (0, 1, 1), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Bottom
        Vertex(position: (-1, -1, 1), normal: (0, -1, 0), material: Material(color: (1, 0, 1), coords: (0, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, -1), normal: (0, -1, 0), material: Material(color: (1, 0, 1), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, -1), normal: (0, -1, 0), material: Material(color: (1, 0, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, 1), normal: (0, -1, 0), material: Material(color: (1, 0, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, 1), normal: (0, -1, 0), material: Material(color: (1, 0, 1), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, -1), normal: (0, -1, 0), material: Material(color: (1, 0, 1), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1))
    ]

    private static let pyramidVertices = [
        // Front
        Vertex(position: (-1, -1, 1), normal: (0, 1, 1), material: Material(color: (0, 1, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (0, 1, 0), normal: (0, 1, 1), material: Material(color: (0, 1, 0), coords: (0.5, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, 1), normal: (0, 1, 1), material: Material(color: (0, 1, 0), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Back
        Vertex(position: (1, -1, -1), normal: (0, 1, -1), material: Material(color: (1, 0, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (0, 1, 0), normal: (0, 1, -1), material: Material(color: (1, 0, 0), coords: (0.5, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, -1), normal: (0, 1, -1), material: Material(color: (1, 0, 0), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Left
        Vertex(position: (-1, -1, -1), normal: (-1, 1, 0), material: Material(color: (0, 0, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (0, 1, 0), normal: (-1, 1, 0), material: Material(color: (0, 0, 1), coords: (0.5, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, 1), normal: (-1, 1, 0), material: Material(color: (0, 0, 1), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Right
        Vertex(position: (1, -1, 1), normal: (1, 1, 0), material: Material(color: (1, 1, 0), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (0, 1, 0), normal: (1, 1, 0), material: Material(color: (1, 1, 0), coords: (0.5, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, -1), normal: (1, 1, 0), material: Material(color: (1, 1, 0), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        // Bottom
        Vertex(position: (-1, -1, 1), normal: (0, -1, 0), material: Material(color: (0, 1, 1), coords: (0, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, -1), normal: (0, -1, 0), material: Material(color: (0, 1, 1), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, -1), normal: (0, -1, 0), material: Material(color: (0, 1, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (-1, -1, 1), normal: (0, -1, 0), material: Material(color: (0, 1, 1), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, 1), normal: (0, -1, 0), material: Material(color: (0, 1, 1), coords: (1, 1), ambient: 1, diffuse: 1, specular: 1)),
        Vertex(position: (1, -1, -1), normal: (0, -1, 0), material: Material(color: (0, 1, 1), coords: (1, 0), ambient: 1, diffuse: 1, specular: 1))
    ]

    private static func vertices(forFilePathUrl url: URL) throws -> [Vertex] {
        var vertices = [Vertex]()
        var positions = [(x: GLfloat, y: GLfloat, z: GLfloat)]()
        var normals = [(x: GLfloat, y: GLfloat, z: GLfloat)]()

        let wholeFile = try String(contentsOf: url, encoding: .utf8)
        let lines = wholeFile.split(whereSeparator: \.isNewline).map { String($0) }

        for line in lines {
            let components = line.replacingOccurrences(of: "//", with: "/0/").split(whereSeparator: \.isWhitespace).map { String($0) }
            switch components[0] {
            case "v":
                if let x = components[safe: 1]?.float, let y = components[safe: 2]?.float, let z = components[safe: 3]?.float {
                    positions.append((x, y, z))
                }
            case "vn":
                if let x = components[safe: 1]?.float, let y = components[safe: 2]?.float, let z = components[safe: 3]?.float {
                    normals.append((x, y, z))
                }
            case "f":
                let a = components[safe: 1]?.split(separator: "/").map { String($0) }
                if let vertexComponents0 = components[safe: 1]?.split(separator: "/").map { String($0) },
                    let positionIndex0 = vertexComponents0[safe: 0]?.int,
                    let normalIndex0 = vertexComponents0[safe: 2]?.int,

                    let vertexComponents1 = components[safe: 2]?.split(separator: "/").map { String($0) },
                    let positionIndex1 = vertexComponents1[safe: 0]?.int,
                    let normalIndex1 = vertexComponents1[safe: 2]?.int,

                    let vertexComponents2 = components[safe: 3]?.split(separator: "/").map { String($0) },
                    let positionIndex2 = vertexComponents2[safe: 0]?.int,
                    let normalIndex2 = vertexComponents2[safe: 2]?.int {
                        let vertex0 = Vertex(position: positions[positionIndex0-1], normal: normals[normalIndex0-1], material: Material(color: (0.5, 0.5, 0.5), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1))
                        let vertex1 = Vertex(position: positions[positionIndex1-1], normal: normals[normalIndex1-1], material: Material(color: (0.5, 0.5, 0.5), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1))
                        let vertex2 = Vertex(position: positions[positionIndex2-1], normal: normals[normalIndex2-1], material: Material(color: (0.5, 0.5, 0.5), coords: (0, 0), ambient: 1, diffuse: 1, specular: 1))
                        vertices.append(vertex0)
                        vertices.append(vertex1)
                        vertices.append(vertex2)
                    }
            default:
                break
            }
        }
        return vertices
    }

    enum Kind {
        case obj(URL)
        case cube
        case pyramid
    }

    private let vertices: [Vertex]
    private var vertexArrayId: GLuint = 0
    private var textureId: GLuint = 0

    init(program: ShaderProgram, kind: Kind, textureBitmap: NSBitmapImageRep?) throws {
        vertices = switch (kind) {
        case .obj(let url):
            try Self.vertices(forFilePathUrl: url)
        case .cube:
            Self.cubeVertices
        case .pyramid:
            Self.pyramidVertices
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

        /*let ambientId = glGetAttribLocation(program.programId, "a_ambient")
        glEnableVertexAttribArray(GLuint(ambientId))
        glVertexAttribPointer(
            GLuint(ambientId),
            1,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.ambient)!)
        )

        let diffuseId = glGetAttribLocation(program.programId, "a_diffuse")
        glEnableVertexAttribArray(GLuint(diffuseId))
        glVertexAttribPointer(
            GLuint(diffuseId),
            1,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.diffuse)!)
        )*/

        /*let specularId = glGetAttribLocation(program.programId, "a_specular")
        glEnableVertexAttribArray(GLuint(specularId))
        glVertexAttribPointer(
            GLuint(specularId),
            1,
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(MemoryLayout<Vertex>.stride),
            UnsafeRawPointer(bitPattern: MemoryLayout<Vertex>.offset(of: \.material)! + MemoryLayout<Material>.offset(of: \.specular)!)
        )*/

        if let textureBitmap {
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
