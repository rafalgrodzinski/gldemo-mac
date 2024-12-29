//
//  Model+Obj.swift
//  glDemo
//
//  Created by Rafał on 2024/12/29.
//

import Foundation
import AppKit

extension Model {
    convenience init(program: ShaderProgram, objFilePathUrl url: URL, textureBitmap: NSBitmapImageRep?) throws {
        var vertices = [Vertex]()
        var positions = [(x: Float, y: Float, z: Float)]()
        var normals = [(x: Float, y: Float, z: Float)]()
        var coords = [(u: Float, v: Float)]()

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
                    let coordIndex0 = vertexComponents0[safe: 1]?.int,
                    let normalIndex0 = vertexComponents0[safe: 2]?.int,

                    let vertexComponents1 = components[safe: 2]?.split(separator: "/").map { String($0) },
                    let positionIndex1 = vertexComponents1[safe: 0]?.int,
                    let coordIndex1 = vertexComponents1[safe: 1]?.int,
                    let normalIndex1 = vertexComponents1[safe: 2]?.int,

                    let vertexComponents2 = components[safe: 3]?.split(separator: "/").map { String($0) },
                    let positionIndex2 = vertexComponents2[safe: 0]?.int,
                    let coordIndex2 = vertexComponents2[safe: 1]?.int,
                    let normalIndex2 = vertexComponents2[safe: 2]?.int {
                        let vertex0 = Vertex(position: positions[positionIndex0-1], normal: normals[normalIndex0-1], material: Material(color: (1, 1, 1), coords: coords[safe: coordIndex0-1] ?? (0, 0), ambient: 0.1, diffuse: 1, specular: 32))
                        let vertex1 = Vertex(position: positions[positionIndex1-1], normal: normals[normalIndex1-1], material: Material(color: (1, 1, 1), coords: coords[safe: coordIndex1-1] ?? (0, 0), ambient: 0.1, diffuse: 1, specular: 32))
                        let vertex2 = Vertex(position: positions[positionIndex2-1], normal: normals[normalIndex2-1], material: Material(color: (1, 1, 1), coords: coords[safe: coordIndex2-1] ?? (0, 0), ambient: 0.1, diffuse: 1, specular: 32))
                        vertices.append(vertex0)
                        vertices.append(vertex1)
                        vertices.append(vertex2)
                    }
            case "vt":
                if let u = components[safe: 1]?.float, let v = components[safe: 2]?.float {
                    coords.append((u, 1 - v))
                }
            default:
                break
            }
        }

        try self.init(program: program, vertices: vertices, textureBitmap: textureBitmap)
    }
}
