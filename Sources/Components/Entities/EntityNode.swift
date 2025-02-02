//
//  EntityNode.swift
//  glDemo
//
//  Created by Rafał on 2025/02/01.
//

import Foundation
import GLKit

class EntityNode: Entity {
    weak var parent: Entity?
    private var children: [Entity]

    var translation: (x: Float, y: Float, z: Float) = (0, 0, 0)
    var rotation: (x: Float, y: Float, z: Float) = (0, 0, 0)
    var scale: (x: Float, y: Float, z: Float) = (1, 1, 1)

    init(children: [Entity] = []) {
        self.children = children
        children.forEach { $0.parent = self }
    }

    func update(withDeltaTime deltaTime: TimeInterval) {
    }

    func prepareForDraw(withProgram program: ShaderProgram) {
        children.forEach { $0.prepareForDraw(withProgram: program) }
    }

    func draw(withProgram program: ShaderProgram) {
        children.forEach { $0.draw(withProgram: program) }
    }
}
