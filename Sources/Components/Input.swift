//
//  Input.swift
//  glDemo
//
//  Created by Rafal on 26/12/2024.
//

import Foundation
import GameController

final class Input {
    struct State {
        let isForward: Bool
        let isBackward: Bool
        let isLeft: Bool
        let isRight: Bool
        let isUp: Bool
        let isDown: Bool
        let mouseDeltaX: GLfloat
        let mouseDeltaY: GLfloat
        let isMouseLeft: Bool
        let isMouseRight: Bool

        var movement: (x: GLfloat, y: GLfloat, z: GLfloat) {
            var x: GLfloat = 0
            if isLeft { x -= 1 }
            if isRight { x += 1 }

            var y: GLfloat = 0
            if isUp { y += 1 }
            if isDown { y -= 1 }

            var z: GLfloat = 0
            if isForward { z -= 1 }
            if isBackward { z += 1 }

            return (x, y, z)
        }

        init(
            isForward: Bool? = nil,
            isBackward: Bool? = nil,
            isLeft: Bool? = nil,
            isRight: Bool? = nil,
            isUp: Bool? = nil,
            isDown: Bool? = nil,
            mouseDeltaX: GLfloat? = nil,
            mouseDeltaY: GLfloat? = nil,
            isMouseLeft: Bool? = nil,
            isMouseRight: Bool? = nil
        ) {
            self.isForward = isForward ?? false
            self.isBackward = isBackward ?? false
            self.isLeft = isLeft ?? false
            self.isRight = isRight ?? false
            self.isUp = isUp ?? false
            self.isDown = isDown ?? false
            self.mouseDeltaX = mouseDeltaX ?? 0
            self.mouseDeltaY = mouseDeltaY ?? 0
            self.isMouseLeft = isMouseLeft ?? false
            self.isMouseRight = isMouseRight ?? false
        }

        func update(
            isForward: Bool? = nil,
            isBackward: Bool? = nil,
            isLeft: Bool? = nil,
            isRight: Bool? = nil,
            isUp: Bool? = nil,
            isDown: Bool? = nil,
            mouseDeltaX: GLfloat? = nil,
            mouseDeltaY: GLfloat? = nil,
            isMouseLeft: Bool? = nil,
            isMouseRight: Bool? = nil
        ) -> State {
            State(
                isForward: isForward ?? self.isForward,
                isBackward: isBackward ?? self.isBackward,
                isLeft: isLeft ?? self.isLeft,
                isRight: isRight ?? self.isRight,
                isUp: isUp ?? self.isUp,
                isDown: isDown ?? self.isDown,
                mouseDeltaX: mouseDeltaX ?? self.mouseDeltaX,
                mouseDeltaY: mouseDeltaY ?? self.mouseDeltaY,
                isMouseLeft: isMouseLeft ?? self.isMouseLeft,
                isMouseRight: isMouseRight ?? self.isMouseRight
            )
        }
    }

    private(set) var state: State = State()

    init() {
        NotificationCenter.default.addObserver(forName: .GCKeyboardDidConnect, object: nil, queue: nil) { notification in
            let keyboard = notification.object as? GCKeyboard
            keyboard?.keyboardInput?.keyChangedHandler = { [weak self] _, _, keyCode, isPressed in
                guard let state = self?.state else { return }
                if keyCode == .keyW {
                    self?.state = state.update(isForward: isPressed)
                }
                if keyCode == .keyS {
                    self?.state = state.update(isBackward: isPressed)
                }
                if keyCode == .keyA {
                    self?.state = state.update(isLeft: isPressed)
                }
                if keyCode == .keyD {
                    self?.state = state.update(isRight: isPressed)
                }
                if keyCode == .keyQ {
                    self?.state = state.update(isDown: isPressed)
                }
                if keyCode == .keyE {
                    self?.state = state.update(isUp: isPressed)
                }
            }
        }

        NotificationCenter.default.addObserver(forName: .GCMouseDidConnect, object: nil, queue: nil) { notification in
            let mouse = notification.object as? GCMouse
            mouse?.mouseInput?.leftButton.pressedChangedHandler = { [weak self] _, _, isPressed in
                guard let state = self?.state else { return }
                self?.state = state.update(isMouseLeft: isPressed)
            }
            mouse?.mouseInput?.rightButton?.pressedChangedHandler = { [weak self] _, _, isPressed in
                guard let state = self?.state else { return }
                self?.state = state.update(isMouseRight: isPressed)
            }
            mouse?.mouseInput?.mouseMovedHandler = { [weak self] _, deltaX, deltaY in
                guard let state = self?.state else { return }
                self?.state = state.update(mouseDeltaX: state.mouseDeltaX + deltaX, mouseDeltaY: state.mouseDeltaY + deltaY)
            }
        }
    }

    func update() {
        state = state.update(mouseDeltaX: 0, mouseDeltaY: 0)
    }
}
