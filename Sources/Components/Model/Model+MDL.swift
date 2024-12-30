//
//  Model+MDL.swift
//  glDemo
//
//  Created by Rafał on 2024/12/29.
//

import Foundation
import OpenGL.GL

extension Model {
    private static let version = 6

    private static let normals = [
        (-0.525731,  0.000000,  0.850651),
        (-0.442863,  0.238856,  0.864188),
        (-0.295242,  0.000000,  0.955423),
        (-0.309017,  0.500000,  0.809017),
        (-0.162460,  0.262866,  0.951056),
        ( 0.000000,  0.000000,  1.000000),
        ( 0.000000,  0.850651,  0.525731),
        (-0.147621,  0.716567,  0.681718),
        ( 0.147621,  0.716567,  0.681718),
        ( 0.000000,  0.525731,  0.850651),
        ( 0.309017,  0.500000,  0.809017),
        ( 0.525731,  0.000000,  0.850651),
        ( 0.295242,  0.000000,  0.955423),
        ( 0.442863,  0.238856,  0.864188),
        ( 0.162460,  0.262866,  0.951056),
        (-0.681718,  0.147621,  0.716567),
        (-0.809017,  0.309017,  0.500000),
        (-0.587785,  0.425325,  0.688191),
        (-0.850651,  0.525731,  0.000000),
        (-0.864188,  0.442863,  0.238856),
        (-0.716567,  0.681718,  0.147621),
        (-0.688191,  0.587785,  0.425325),
        (-0.500000,  0.809017,  0.309017),
        (-0.238856,  0.864188,  0.442863),
        (-0.425325,  0.688191,  0.587785),
        (-0.716567,  0.681718, -0.147621),
        (-0.500000,  0.809017, -0.309017),
        (-0.525731,  0.850651,  0.000000),
        ( 0.000000,  0.850651, -0.525731),
        (-0.238856,  0.864188, -0.442863),
        ( 0.000000,  0.955423, -0.295242),
        (-0.262866,  0.951056, -0.162460),
        ( 0.000000,  1.000000,  0.000000),
        ( 0.000000,  0.955423,  0.295242),
        (-0.262866,  0.951056,  0.162460),
        ( 0.238856,  0.864188,  0.442863),
        ( 0.262866,  0.951056,  0.162460),
        ( 0.500000,  0.809017,  0.309017),
        ( 0.238856,  0.864188, -0.442863),
        ( 0.262866,  0.951056, -0.162460),
        ( 0.500000,  0.809017, -0.309017),
        ( 0.850651,  0.525731,  0.000000),
        ( 0.716567,  0.681718,  0.147621),
        ( 0.716567,  0.681718, -0.147621),
        ( 0.525731,  0.850651,  0.000000),
        ( 0.425325,  0.688191,  0.587785),
        ( 0.864188,  0.442863,  0.238856),
        ( 0.688191,  0.587785,  0.425325),
        ( 0.809017,  0.309017,  0.500000),
        ( 0.681718,  0.147621,  0.716567),
        ( 0.587785,  0.425325,  0.688191),
        ( 0.955423,  0.295242,  0.000000),
        ( 1.000000,  0.000000,  0.000000),
        ( 0.951056,  0.162460,  0.262866),
        ( 0.850651, -0.525731,  0.000000),
        ( 0.955423, -0.295242,  0.000000),
        ( 0.864188, -0.442863,  0.238856),
        ( 0.951056, -0.162460,  0.262866),
        ( 0.809017, -0.309017,  0.500000),
        ( 0.681718, -0.147621,  0.716567),
        ( 0.850651,  0.000000,  0.525731),
        ( 0.864188,  0.442863, -0.238856),
        ( 0.809017,  0.309017, -0.500000),
        ( 0.951056,  0.162460, -0.262866),
        ( 0.525731,  0.000000, -0.850651),
        ( 0.681718,  0.147621, -0.716567),
        ( 0.681718, -0.147621, -0.716567),
        ( 0.850651,  0.000000, -0.525731),
        ( 0.809017, -0.309017, -0.500000),
        ( 0.864188, -0.442863, -0.238856),
        ( 0.951056, -0.162460, -0.262866),
        ( 0.147621,  0.716567, -0.681718),
        ( 0.309017,  0.500000, -0.809017),
        ( 0.425325,  0.688191, -0.587785),
        ( 0.442863,  0.238856, -0.864188),
        ( 0.587785,  0.425325, -0.688191),
        ( 0.688191,  0.587785, -0.425325),
        (-0.147621,  0.716567, -0.681718),
        (-0.309017,  0.500000, -0.809017),
        ( 0.000000,  0.525731, -0.850651),
        (-0.525731,  0.000000, -0.850651),
        (-0.442863,  0.238856, -0.864188),
        (-0.295242,  0.000000, -0.955423),
        (-0.162460,  0.262866, -0.951056),
        ( 0.000000,  0.000000, -1.000000),
        ( 0.295242,  0.000000, -0.955423),
        ( 0.162460,  0.262866, -0.951056),
        (-0.442863, -0.238856, -0.864188),
        (-0.309017, -0.500000, -0.809017),
        (-0.162460, -0.262866, -0.951056),
        ( 0.000000, -0.850651, -0.525731),
        (-0.147621, -0.716567, -0.681718),
        ( 0.147621, -0.716567, -0.681718),
        ( 0.000000, -0.525731, -0.850651),
        ( 0.309017, -0.500000, -0.809017),
        ( 0.442863, -0.238856, -0.864188),
        ( 0.162460, -0.262866, -0.951056),
        ( 0.238856, -0.864188, -0.442863),
        ( 0.500000, -0.809017, -0.309017),
        ( 0.425325, -0.688191, -0.587785),
        ( 0.716567, -0.681718, -0.147621),
        ( 0.688191, -0.587785, -0.425325),
        ( 0.587785, -0.425325, -0.688191),
        ( 0.000000, -0.955423, -0.295242),
        ( 0.000000, -1.000000,  0.000000),
        ( 0.262866, -0.951056, -0.162460),
        ( 0.000000, -0.850651,  0.525731),
        ( 0.000000, -0.955423,  0.295242),
        ( 0.238856, -0.864188,  0.442863),
        ( 0.262866, -0.951056,  0.162460),
        ( 0.500000, -0.809017,  0.309017),
        ( 0.716567, -0.681718,  0.147621),
        ( 0.525731, -0.850651,  0.000000),
        (-0.238856, -0.864188, -0.442863),
        (-0.500000, -0.809017, -0.309017),
        (-0.262866, -0.951056, -0.162460),
        (-0.850651, -0.525731,  0.000000),
        (-0.716567, -0.681718, -0.147621),
        (-0.716567, -0.681718,  0.147621),
        (-0.525731, -0.850651,  0.000000),
        (-0.500000, -0.809017,  0.309017),
        (-0.238856, -0.864188,  0.442863),
        (-0.262866, -0.951056,  0.162460),
        (-0.864188, -0.442863,  0.238856),
        (-0.809017, -0.309017,  0.500000),
        (-0.688191, -0.587785,  0.425325),
        (-0.681718, -0.147621,  0.716567),
        (-0.442863, -0.238856,  0.864188),
        (-0.587785, -0.425325,  0.688191),
        (-0.309017, -0.500000,  0.809017),
        (-0.147621, -0.716567,  0.681718),
        (-0.425325, -0.688191,  0.587785),
        (-0.162460, -0.262866,  0.951056),
        ( 0.442863, -0.238856,  0.864188),
        ( 0.162460, -0.262866,  0.951056),
        ( 0.309017, -0.500000,  0.809017),
        ( 0.147621, -0.716567,  0.681718),
        ( 0.000000, -0.525731,  0.850651),
        ( 0.425325, -0.688191,  0.587785),
        ( 0.587785, -0.425325,  0.688191),
        ( 0.688191, -0.587785,  0.425325),
        (-0.955423,  0.295242,  0.000000),
        (-0.951056,  0.162460,  0.262866),
        (-1.000000,  0.000000,  0.000000),
        (-0.850651,  0.000000,  0.525731),
        (-0.955423, -0.295242,  0.000000),
        (-0.951056, -0.162460,  0.262866),
        (-0.864188,  0.442863, -0.238856),
        (-0.951056,  0.162460, -0.262866),
        (-0.809017,  0.309017, -0.500000),
        (-0.864188, -0.442863, -0.238856),
        (-0.951056, -0.162460, -0.262866),
        (-0.809017, -0.309017, -0.500000),
        (-0.681718,  0.147621, -0.716567),
        (-0.681718, -0.147621, -0.716567),
        (-0.850651,  0.000000, -0.525731),
        (-0.688191,  0.587785, -0.425325),
        (-0.587785,  0.425325, -0.688191),
        (-0.425325,  0.688191, -0.587785),
        (-0.425325, -0.688191, -0.587785),
        (-0.587785, -0.425325, -0.688191),
        (-0.688191, -0.587785, -0.425325)
    ]

    struct Header {
        let ident: Int32 = 0
        let version: Int32 = 0
        let scale: (sx: Float, sy: Float, sz: Float) = (0, 0, 0)
        let translate: (x: Float, y: Float, z: Float) = (0, 0, 0)
        let boundingRadius: Float = 0
        let eyePostion: (x: Float, y: Float, z: Float) = (0, 0, 0)

        let texturesCount: Int32 = 0
        let textureWidth: Int32 = 0
        let textureHeight: Int32 = 0

        let verticesCount: Int32 = 0
        let trianglesCount: Int32 = 0
        let framesCount: Int32 = 0

        let syncType: Int32 = 0
        let flags: Int32 = 0
        let size: Float = 0
    }

    struct MdlVertex {
        let vertex: (x: UInt8, y: UInt8, z: UInt8) = (0, 0, 0)
        let normalIndex: UInt8 = 0
    }

    struct MdlFrame {
        var isGroup: Int32 = 0
        var boundingBoxMin = MdlVertex()
        var boundingBoxMax = MdlVertex()
        let name = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        let vertices: UnsafeMutablePointer<MdlVertex>
    }

    struct MdlCoord {
        let isOnboundary: Int32 = 0
        let coord: (u: Int32, v: Int32) = (0, 0)
    }

    struct MdlTriangle {
        let isFrontFace: Int32 = 0
        let vertexIndices: (v0: Int32, v1: Int32, v2: Int32) = (0, 0, 0)
    }

    convenience init(program: ShaderProgram, mdlFilePathUrl url: URL) throws {
        var expectedIdent: UInt32 = 0
        expectedIdent += ("I".unicodeScalars.first?.value ?? 0)
        expectedIdent += ("D".unicodeScalars.first?.value ?? 0) << 8
        expectedIdent += ("P".unicodeScalars.first?.value ?? 0) << 16
        expectedIdent += ("O".unicodeScalars.first?.value ?? 0) << 24

        var vertices = [Vertex]()
        //var header = UnsafeMutablePointer<Header>.allocate(capacity: 1)
        var header = Header()
        guard var data = NSData(contentsOf: url) else { throw AppError(description: "Error reading MDL data") }
        let range = data.startIndex..<data.index(data.startIndex, offsetBy: MemoryLayout<Header>.size)
        withUnsafeMutableBytes(of: &header) { pointer in
            data.copyBytes(to: pointer, from: range)
        }

        guard header.ident == expectedIdent && header.version == Self.version else { throw AppError(description: "Not a valid MDL file") }

        var pointer = data.bytes

        // Textures
        pointer = pointer.advanced(by: MemoryLayout<Header>.size)
        for i in 0..<header.texturesCount {
            let isGroup = pointer.load(as: Int32.self)
            pointer = pointer.advanced(by: MemoryLayout<Int32>.size)
            if isGroup != 0 {
                throw AppError(description: "Not yet implemented")
            } else {
                pointer = pointer.advanced(by: MemoryLayout<UInt8>.size * Int(header.textureWidth) * Int(header.textureHeight))
            }
        }

        // Coordinates
        //var coordinates = UnsafeMutablePointer<MdlCoord>.allocate(capacity: Int(header.verticesCount))
        //coordinates.initialize(from: pointer.assumingMemoryBound(to: MdlCoord.self), count: Int(header.verticesCount))
        pointer = pointer.advanced(by: MemoryLayout<MdlCoord>.size * Int(header.verticesCount))

        // Triangles
        var triangles = UnsafeMutablePointer<MdlTriangle>.allocate(capacity: Int(header.trianglesCount))
        triangles.initialize(from: pointer.assumingMemoryBound(to: MdlTriangle.self), count: Int(header.trianglesCount))
        pointer = pointer.advanced(by: MemoryLayout<MdlTriangle>.size * Int(header.trianglesCount))

        // Model frames
        for i in 0..<1 {//header.framesCount {
            let isGroup = pointer.load(as: Int32.self)
            if isGroup != 0 {
                throw AppError(description: "Not yet implemented")
            } else {
                var frame = MdlFrame(vertices: UnsafeMutablePointer.allocate(capacity: Int(header.verticesCount)))
                frame.isGroup = pointer.load(as: Int32.self)
                pointer = pointer.advanced(by: MemoryLayout<Int32>.size)
                frame.boundingBoxMin = pointer.load(as: MdlVertex.self)
                pointer = pointer.advanced(by: MemoryLayout<MdlVertex>.size)
                frame.boundingBoxMax = pointer.load(as: MdlVertex.self)
                pointer = pointer.advanced(by: MemoryLayout<MdlVertex>.size)
                frame.name.initialize(from: pointer.assumingMemoryBound(to: UInt8.self), count: 16)
                pointer = pointer.advanced(by: MemoryLayout<UInt8>.size * 16)
                frame.vertices.initialize(from: pointer.assumingMemoryBound(to: MdlVertex.self), count: Int(header.verticesCount))

                for i in 0..<header.trianglesCount {
                    let triangle = triangles.advanced(by: Int(i)).pointee
                    // V0
                    let mdlVertex0 = frame.vertices.advanced(by: Int(triangle.vertexIndices.v0)).pointee
                    let vertex0 = Vertex(
                        position: (
                            header.scale.sx * Float(mdlVertex0.vertex.x) + header.translate.x,
                            header.scale.sy * Float(mdlVertex0.vertex.y) + header.translate.y,
                            header.scale.sz * Float(mdlVertex0.vertex.z) + header.translate.z
                        ),
                        normal: (
                            Float(Self.normals[Int(mdlVertex0.normalIndex)].0),
                            Float(Self.normals[Int(mdlVertex0.normalIndex)].1),
                            Float(Self.normals[Int(mdlVertex0.normalIndex)].2)
                        ),
                        material: Material(color: (1, 1, 1), coords: (0, 0), ambient: 0.1, diffuse: 1, specular: 32)
                    )
                    vertices.append(vertex0)

                    // V1
                    let mdlVertex1 = frame.vertices.advanced(by: Int(triangle.vertexIndices.v1)).pointee
                    let vertex1 = Vertex(
                        position: (
                            header.scale.sx * Float(mdlVertex1.vertex.x) + header.translate.x,
                            header.scale.sy * Float(mdlVertex1.vertex.y) + header.translate.y,
                            header.scale.sz * Float(mdlVertex1.vertex.z) + header.translate.z
                        ),
                        normal: (
                            Float(Self.normals[Int(mdlVertex1.normalIndex)].0),
                            Float(Self.normals[Int(mdlVertex1.normalIndex)].1),
                            Float(Self.normals[Int(mdlVertex1.normalIndex)].2)
                        ),
                        material: Material(color: (1, 1, 1), coords: (0, 0), ambient: 0.1, diffuse: 1, specular: 32)
                    )
                    vertices.append(vertex1)

                    // V2
                    let mdlVertex2 = frame.vertices.advanced(by: Int(triangle.vertexIndices.v2)).pointee
                    let vertex2 = Vertex(
                        position: (
                            header.scale.sx * Float(mdlVertex2.vertex.x) + header.translate.x,
                            header.scale.sy * Float(mdlVertex2.vertex.y) + header.translate.y,
                            header.scale.sz * Float(mdlVertex2.vertex.z) + header.translate.z
                        ),
                        normal: (
                            Float(Self.normals[Int(mdlVertex2.normalIndex)].0),
                            Float(Self.normals[Int(mdlVertex2.normalIndex)].1),
                            Float(Self.normals[Int(mdlVertex2.normalIndex)].2)
                        ),
                        material: Material(color: (1, 1, 1), coords: (0, 0), ambient: 0.1, diffuse: 1, specular: 32)
                    )
                    vertices.append(vertex2)
                }
            }
        }

        try self.init(program: program, vertices: vertices, textureBitmap: nil)
    }
}
