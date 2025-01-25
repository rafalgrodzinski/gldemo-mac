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

    private let phongRenderPass: PhongRenderPass
    private let debugRenderPass: DebugRenderPass
    private let gridRenderPass: GridRenderPass
    private let camera: Camera
    private let lights: [Light]
    private let models: [Model]
    private let input: Input

    init(input: Input) throws {
        self.input = input
        phongRenderPass = try PhongRenderPass()
        debugRenderPass = try DebugRenderPass()
        gridRenderPass = try GridRenderPass()

        debugRenderPass.shouldShowMesh = true
        camera = Camera(kind: .perspective(angle: 90, width: 0, height: 0, near: 0.1, far: 1000))
        lights = [
            try Light(kind: .directional(direction: (1, -1, -1), intensity: 0.5), color: (1, 1, 1)),
            try Light(kind: .point(position: (10, 10, 10), linearAttenuation: 0.01, quadraticAttenuation: 0.001), color: (1, 0, 0))
            ]
        models = [
            try Model(program: phongRenderPass.program, kind: .cube),
            try Model(program: phongRenderPass.program, objFilePathUrl: Bundle.main.url(forResource: "Bear", withExtension: "obj")!, texture: Texture(imageName: "Bear.png")),
            //try Model(program: phongRenderPass.program, mdlFilePathUrl: Bundle.main.url(forResource: "player", withExtension: "mdl")!),
        ]
    }

    func resize(width: Float, height: Float) {
        //glViewport(0, 0, GLsizei(width * 2), GLsizei(height * 2))
        camera.resize(width: width, height: height)
    }

    func update(deltaTime: TimeInterval) {
        camera.update(deltaTime: deltaTime, inputState: input.state)
        models.forEach { $0.update(deltaTime: deltaTime) }
        input.update()
    }

    func draw(configs: [GLView.Config]) {
        glClearColor(0, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))

        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))

        phongRenderPass.draw(models: models, camera: camera, lights: lights, configs: configs)
        debugRenderPass.draw(models: models, camera: camera, configs: configs)
        gridRenderPass.draw(camera: camera)
    }
}
