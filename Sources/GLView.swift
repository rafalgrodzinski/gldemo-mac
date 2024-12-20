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
        static let tRange: ClosedRange<Float> = -1...1
        static let rRange: ClosedRange<Float> = -180...180

        let tx: Float
        let ty: Float
        let tz: Float

        let rx: Float
        let ry: Float
        let rz: Float

        init(tx: Float? = nil, ty: Float? = nil, tz: Float? = nil,
             rx: Float? = nil, ry: Float? = nil, rz: Float? = nil) {
            self.tx = tx ?? 0
            self.ty = ty ?? 0
            self.tz = tz ?? 0

            self.rx = rx ?? 0
            self.ry = ry ?? 0
            self.rz = rz ?? 0
        }

        func updated(tx: Float? = nil, ty: Float? = nil, tz: Float? = nil,
                    rx: Float? = nil, ry: Float? = nil, rz: Float? = nil) -> Config {
            Config(tx: tx ?? self.tx, ty: ty ?? self.ty, tz: tz ?? self.tz,
                   rx: rx ?? self.rx, ry: ry ?? self.ry, rz: rz ?? self.rz)
        }
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
        debugPrint(config)
    } }
}
