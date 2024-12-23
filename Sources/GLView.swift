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
        static let tRange: ClosedRange<Float> = -10...10
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
    let configs: [GLView.Config]

    func makeNSView(context: Context) -> GLView {
        GLView()
    }
    
    func updateNSView(_ nsView: GLView, context: Context) {
        nsView.configs = configs
    }
}

class GLView: NSOpenGLView {
    private var renderer: Renderer?
    private var displayLink: CVDisplayLink?
    private var previousTime: Double?
    var configs = [Config]()

    init() {
        super.init(frame: .zero, pixelFormat: Renderer.pixelFormat)!
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareOpenGL() {
        super.prepareOpenGL()
        do {
            renderer = try Renderer()
        } catch {
            fatalError(error.description)
        }
        var oldTime: Double?

        let displayLinkCallback: CVDisplayLinkOutputCallback = { (_, inNow, _, _, _, displayLinkContext) -> CVReturn in
            let view = unsafeBitCast(displayLinkContext, to: GLView.self)

            let time = Double(inNow.pointee.videoTime) / Double(inNow.pointee.videoTimeScale)
            if let previousTime = view.previousTime {
                let deltaTime = time - previousTime
                view.renderer?.update(deltaTime: deltaTime)
            }
            view.previousTime = time
            view.update()
            
            return kCVReturnSuccess
        }

        CVDisplayLinkCreateWithCGDisplay(CGMainDisplayID(), &displayLink)
        guard let displayLink = self.displayLink else { fatalError() }
        CVDisplayLinkSetOutputCallback(displayLink, displayLinkCallback, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))
        CVDisplayLinkStart(displayLink)
    }

    override func reshape() {
        renderer?.resize(width: Float(frame.width), height: Float(frame.height))
    }

    override func update() {
        guard let context = openGLContext else { return }
        context.makeCurrentContext()
        CGLLockContext(context.cglContextObj!)

        renderer?.draw(configs: configs)

        CGLFlushDrawable(context.cglContextObj!)
        CGLUnlockContext(context.cglContextObj!)
    }
}
