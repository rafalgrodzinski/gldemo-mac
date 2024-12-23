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

    private let renderPasses: [RenderPass]
    private var program: GLuint = 0

    init() throws {
        renderPasses = [
            try PhongRenderPass()
        ]
    }

    func resize(width: Float, height: Float) {
        glViewport(0, 0, GLsizei(width), GLsizei(height))
    }

    func update(deltaTime: TimeInterval) {
    }

    func draw() {
        glClearColor(0, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))

        for renderPass in renderPasses {
            renderPass.initFrame()
        }
    }
}
