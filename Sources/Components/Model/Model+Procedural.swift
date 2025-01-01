//
//  Model+Procedural.swift
//  glDemo
//
//  Created by Rafał on 2024/12/29.
//

import Foundation

extension Model {
    enum ProceduralModelKind {
        case cube
        case pyramid
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

    convenience init(program: ShaderProgram, kind: ProceduralModelKind) throws {
        let vertices: [Vertex]
        switch kind {
        case .cube: vertices = Self.cubeVertices
        case .pyramid: vertices = Self.pyramidVertices
        }

        try self.init(program: program, frames: [vertices], frameDuration: 0, texture: nil)
    }
}
