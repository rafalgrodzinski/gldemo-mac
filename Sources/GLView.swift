//
//  GLView.swift
//  glDemo
//
//  Created by Rafal on 20/12/2024.
//

import SwiftUI
import Cocoa
import OpenGL.GL

extension GLView {
    struct Config {
    }
}

struct GLViewWrapper: NSViewRepresentable {
    let config: GLView.Config

    func makeNSView(context: Context) -> GLView {
        GLView()
    }
    
    func updateNSView(_ nsView: GLView, context: Context) {
        nsView.config = config
    }
}

class GLView: NSOpenGLView {
    var config: Config = Config() { didSet {
    } }
}
