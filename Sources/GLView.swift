//
//  GLView.swift
//  glDemo
//
//  Created by Rafal on 20/12/2024.
//

import SwiftUI
import Cocoa
import OpenGL.GL

struct GLViewWrapper: NSViewRepresentable {
    let config: Config

    func makeNSView(context: Context) -> GLView {
        GLView()
    }
    
    func updateNSView(_ nsView: GLView, context: Context) {
        nsView.config = config
    }
}

class GLView: NSOpenGLView {
    private var renderer: Renderer?
    private var displayLink: CVDisplayLink?
    private var previousTime: Double?
    var config = Config()
    private let input = Input()

    init() {
        super.init(frame: .zero, pixelFormat: Renderer.pixelFormat)!
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareOpenGL() {
        super.prepareOpenGL()
        do {
            renderer = try Renderer(input: input)
        } catch {
            fatalError(error.description)
        }
        var oldTime: Double?

        let displayLinkCallback: CVDisplayLinkOutputCallback = {(_, inNow, _, _, _, displayLinkContext) -> CVReturn in
            let view = unsafeBitCast(displayLinkContext, to: GLView.self)

            let time = Double(inNow.pointee.videoTime) / Double(inNow.pointee.videoTimeScale)
            if let previousTime = view.previousTime {
                let deltaTime = time - previousTime
                view.renderer?.update(deltaTime: deltaTime, config: view.config)
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
        addTrackingArea(NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self))
        renderer?.resize(width: Float(frame.width), height: Float(frame.height))
    }

    override func update() {
        guard let context = openGLContext else { return }
        context.makeCurrentContext()
        CGLLockContext(context.cglContextObj!)

        renderer?.draw()

        CGLFlushDrawable(context.cglContextObj!)
        CGLUnlockContext(context.cglContextObj!)
    }
    
    override func mouseEntered(with event: NSEvent) {
        input.update(isMouseInView: true)
    }
    
    override func mouseExited(with event: NSEvent) {
        input.update(isMouseInView: false)
    }
}
