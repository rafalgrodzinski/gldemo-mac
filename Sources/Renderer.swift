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

    private var program: GLuint = 0

    init() throws {
        let vertexShader = try shader(forType: GL_VERTEX_SHADER, filePathUrl: Bundle.main.url(forResource: "shader", withExtension: "vsh")!)
        let fragmentShader = try shader(forType: GL_FRAGMENT_SHADER, filePathUrl: Bundle.main.url(forResource: "shader", withExtension: "fsh")!)
        self.program = try program(forVertexShader: vertexShader, fragmentShader: fragmentShader)
    }

    private func shader(forType type: Int32, filePathUrl: URL) throws -> GLuint {
        let shader = glCreateShader(GLenum(type))
        let src = try String(contentsOf: filePathUrl, encoding: .utf8)
        var cSrc = (src as NSString).utf8String
        glShaderSource(shader, 1, &cSrc, nil)
        glCompileShader(shader)

        var infoLog = [GLchar](repeating: 0, count: 4096)
        var infoLogLength: GLsizei = 0
        glGetShaderInfoLog(shader, 4096, &infoLogLength, &infoLog)
        if infoLogLength > 0 {
            throw AppError(description: String(cString: infoLog))
        }

        return shader
    }

    private func program(forVertexShader vertexShader: GLuint, fragmentShader: GLuint) throws -> GLuint {
        let program = glCreateProgram()
        glAttachShader(program, vertexShader)
        glAttachShader(program, fragmentShader)
        glLinkProgram(program)

        var infoLog = [GLchar](repeating: 0, count: 4096)
        var infoLogLength: GLsizei = 0
        glGetProgramInfoLog(program, 4096, &infoLogLength, &infoLog)
        if infoLogLength > 0 {
            throw AppError(description: String(cString: infoLog))
        }

        return program
    }

    func resize(width: Float, height: Float) {
        glViewport(0, 0, GLsizei(width), GLsizei(height))
    }

    func update(deltaTime: TimeInterval) {
    }

    func draw() {
        glClearColor(0, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
}
