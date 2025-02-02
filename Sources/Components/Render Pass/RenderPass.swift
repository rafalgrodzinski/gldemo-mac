//
//  RenderPass.swift
//  glDemo
//
//  Created by Rafał on 2025/02/01.
//

import Foundation

protocol RenderPass {
    func draw(entities: [Entity], camera: Camera)
}
