//
//  ShaderProgram.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import OpenGL.GL

final class ShaderProgram {
    private(set) var programId: GLuint = 0

    init(vertexShaderFilePathUrl: URL, fragmentShaderFilePathUrl: URL) throws {
        let vertexShader = try shader(forType: GL_VERTEX_SHADER, filePathUrl: vertexShaderFilePathUrl)
        let fragmentShader = try shader(forType: GL_FRAGMENT_SHADER, filePathUrl: fragmentShaderFilePathUrl)
        self.programId = try program(forVertexShader: vertexShader, fragmentShader: fragmentShader)
    }

    deinit {
        glDeleteProgram(programId)
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
            glDeleteShader(shader)
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
            glDeleteProgram(program)
            throw AppError(description: String(cString: infoLog))
        }

        return program
    }
}
