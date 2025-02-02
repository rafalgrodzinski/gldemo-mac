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

    private let camera: Camera
    private let renderPasses: [RenderPass]
    private let debugRenderPass: DebugRenderPass
    private let gridRenderPass: GridRenderPass
    private let skyboxRenderPass: SkyboxRenderPass
    private let entities: [Entity]
    private let input: Input

    var config: Config = Config()

    init(input: Input) throws {
        self.input = input

        camera = Camera(kind: .perspective(angle: 90, width: 0, height: 0, near: 0.1, far: 1000))

        skyboxRenderPass = try SkyboxRenderPass()
        let phongRenderPass = try PhongRenderPass()
        debugRenderPass = try DebugRenderPass()
        gridRenderPass = try GridRenderPass()
        renderPasses = [skyboxRenderPass, phongRenderPass, debugRenderPass, gridRenderPass]

        entities = [
            EntityNode(children: [
                try Model(program: phongRenderPass.program, kind: .cube),
                try Model(program: phongRenderPass.program, objFilePathUrl: Bundle.main.url(forResource: "Bear", withExtension: "obj")!, texture: Texture(imageName: "Bear.png"))
            ]),
            try Model(program: phongRenderPass.program, mdlFilePathUrl: Bundle.main.url(forResource: "player", withExtension: "mdl")!),
            try Light(kind: .directional(direction: (1, -1, -1), intensity: 0.5), color: (1, 1, 1)),
            try Light(kind: .point(position: (10, 10, 10), linearAttenuation: 0.01, quadraticAttenuation: 0.001), color: (1, 0, 0))
        ]
    }

    func resize(width: Float, height: Float) {
        //glViewport(0, 0, GLsizei(width * 2), GLsizei(height * 2))
        camera.resize(width: width, height: height)
    }

    func update(deltaTime: TimeInterval, config: Config) {
        camera.update(deltaTime: deltaTime, inputState: input.state)
        entities.forEach { $0.update(withDeltaTime: deltaTime) }
        input.update()

        skyboxRenderPass.isEnabled = config.sceneConfig.isSkyboxOn
        debugRenderPass.isNormalsOn = config.sceneConfig.isNormalsOn
        debugRenderPass.isMeshOn = config.sceneConfig.isMeshOn
        gridRenderPass.isGridOn = config.sceneConfig.isGridOn
        gridRenderPass.isAxesOn = config.sceneConfig.isAxesOn

        for (index, config) in config.modelConfigs.enumerated() {
            entities[safe: index]?.translation = (config.tx, config.ty, config.tz)
            entities[safe: index]?.rotation = (config.rx.radians, config.ry.radians, config.rz.radians)
            entities[safe: index]?.scale = (config.sx, config.sy, config.sz)
        }
    }

    func draw() {
        glClearColor(0, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))

        renderPasses.forEach { $0.draw(entities: entities, camera: camera) }
    }
}
