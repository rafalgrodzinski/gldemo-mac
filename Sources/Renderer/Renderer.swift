//
//  Renderer.swift
//  glDemo
//
//  Created by Rafal on 20/12/2024.
//

import Foundation
import GLKit
import OpenGL.GL

final class Renderer {
    static var pixelFormat: NSOpenGLPixelFormat {
        let attributes = [
            NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion4_1Core,
            NSOpenGLPFADepthSize, 16,
            NSOpenGLPFADoubleBuffer,
            0
        ].map { NSOpenGLPixelFormatAttribute($0) }
        guard let format = NSOpenGLPixelFormat(attributes: attributes) else { fatalError() }
        return format
    }

    private let renderPass: PhongRenderPass
    private let camera: Camera
    private let lights: [Light]
    private let models: [Model]
    private let input: Input

    init(input: Input) throws {
        self.input = input
        renderPass = try PhongRenderPass()
        camera = Camera(kind: .perspective(angle: 90, width: 0, height: 0, near: 0.1, far: 1000))
        lights = [
            try Light(kind: .directional(direction: (1, -1, -1), intensity: 0.5), color: (1, 1, 1)),
            try Light(kind: .point(position: (10, 10, 10), linearAttenuation: 0.01, quadraticAttenuation: 0.001), color: (1, 0, 0))
            ]
        models = [
            try Model(program: renderPass.program, kind: .cube),
            try Model(program: renderPass.program, objFilePathUrl: Bundle.main.url(forResource: "Bear", withExtension: "obj")!, texture: Texture(imageName: "Bear.png")),
            try Model(program: renderPass.program, mdlFilePathUrl: Bundle.main.url(forResource: "player", withExtension: "mdl")!),
        ]
    }

    func resize(width: Float, height: Float) {
        //glViewport(0, 0, GLsizei(width * 2), GLsizei(height * 2))
        camera.resize(width: width, height: height)
    }

    func update(deltaTime: TimeInterval) {
        camera.update(deltaTime: deltaTime, inputState: input.state)
        input.update()
        models.forEach {
            $0.update(deltaTime: deltaTime)
        }
    }

    func draw(configs: [GLView.Config]) {
        renderPass.initFrame()
        camera.initFrame(program: renderPass.program)
        lights.forEach {
            $0.initFrame(program: renderPass.program)
        }

        renderPass.draw(models: models, configs: configs)
    }
}
