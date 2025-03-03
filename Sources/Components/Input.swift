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
        let forwardDelta: Float
        let sideDelta: Float
        let upDelta: Float
        let isMouseInView: Bool
        let mouseDeltaX: GLfloat
        let mouseDeltaY: GLfloat
        let isMouseLeft: Bool
        let isMouseRight: Bool

        var movement: (x: GLfloat, y: GLfloat, z: GLfloat) {
            return (sideDelta, upDelta, forwardDelta)
        }

        init(
            forwardDelta: Float? = nil,
            sideDelta: Float? = nil,
            upDelta: Float? = nil,
            isMouseInView: Bool? = nil,
            mouseDeltaX: GLfloat? = nil,
            mouseDeltaY: GLfloat? = nil,
            isMouseLeft: Bool? = nil,
            isMouseRight: Bool? = nil
        ) {
            self.forwardDelta = forwardDelta ?? 0
            self.sideDelta = sideDelta ?? 0
            self.upDelta = upDelta ?? 0
            self.isMouseInView = isMouseInView ?? false
            self.mouseDeltaX = mouseDeltaX ?? 0
            self.mouseDeltaY = mouseDeltaY ?? 0
            self.isMouseLeft = isMouseLeft ?? false
            self.isMouseRight = isMouseRight ?? false
        }

        func update(
            forwardDelta: Float? = nil,
            sideDelta: Float? = nil,
            upDelta: Float? = nil,
            isMouseInView: Bool? = nil,
            mouseDeltaX: GLfloat? = nil,
            mouseDeltaY: GLfloat? = nil,
            isMouseLeft: Bool? = nil,
            isMouseRight: Bool? = nil
        ) -> State {
            State(
                forwardDelta: forwardDelta ?? self.forwardDelta,
                sideDelta: sideDelta ?? self.sideDelta,
                upDelta: upDelta ?? self.upDelta,
                isMouseInView: isMouseInView ?? self.isMouseInView,
                mouseDeltaX: mouseDeltaX ?? self.mouseDeltaX,
                mouseDeltaY: mouseDeltaY ?? self.mouseDeltaY,
                isMouseLeft: isMouseLeft ?? self.isMouseLeft,
                isMouseRight: isMouseRight ?? self.isMouseRight
            )
        }
    }

    private(set) var state: State = State()
    private var wasGamepadInput = false

    init() {
        NotificationCenter.default.addObserver(forName: .GCKeyboardDidConnect, object: nil, queue: nil) { notification in
            let keyboard = notification.object as? GCKeyboard
            keyboard?.keyboardInput?.keyChangedHandler = { [weak self] _, _, keyCode, isPressed in
                guard let state = self?.state else { return }
                self?.wasGamepadInput = false
                if keyCode == .keyW {
                    self?.state = state.update(forwardDelta: isPressed ? -1 : 0)
                }
                if keyCode == .keyS {
                    self?.state = state.update(forwardDelta:  isPressed ? 1 : 0)
                }
                if keyCode == .keyA {
                    self?.state = state.update(sideDelta:  isPressed ? -1 : 0)
                }
                if keyCode == .keyD {
                    self?.state = state.update(sideDelta:  isPressed ? 1 : 0)
                }
                if keyCode == .keyQ {
                    self?.state = state.update(upDelta:  isPressed ? -1 : 0)
                }
                if keyCode == .keyE {
                    self?.state = state.update(upDelta:  isPressed ? 1 : 0)
                }
            }
        }

        NotificationCenter.default.addObserver(forName: .GCMouseDidConnect, object: nil, queue: nil) { notification in
            let mouse = notification.object as? GCMouse
            mouse?.mouseInput?.leftButton.pressedChangedHandler = { [weak self] _, _, isPressed in
                guard let state = self?.state else { return }
                self?.wasGamepadInput = false
                self?.state = state.update(isMouseLeft: isPressed)
            }
            mouse?.mouseInput?.rightButton?.pressedChangedHandler = { [weak self] _, _, isPressed in
                guard let state = self?.state else { return }
                self?.wasGamepadInput = false
                self?.state = state.update(isMouseRight: isPressed)
            }
            mouse?.mouseInput?.mouseMovedHandler = { [weak self] _, deltaX, deltaY in
                guard let state = self?.state else { return }
                self?.wasGamepadInput = false
                self?.state = state.update(mouseDeltaX: state.mouseDeltaX + deltaX, mouseDeltaY: state.mouseDeltaY + deltaY)
            }
        }

        NotificationCenter.default.addObserver(forName: .GCControllerDidConnect, object: nil, queue: nil) { notification in
            let controller = notification.object as? GCController
            controller?.extendedGamepad?.valueChangedHandler = { [weak self] (gamepad, element) in
                guard let state = self?.state else { return }
                self?.wasGamepadInput = true
                var upDelta: Float = 0
                if gamepad.leftTrigger.value > 0 {
                    upDelta = -gamepad.leftTrigger.value
                } else {
                    upDelta = gamepad.rightTrigger.value
                }
                self?.state = state.update(
                    forwardDelta: -gamepad.leftThumbstick.yAxis.value,
                    sideDelta: gamepad.leftThumbstick.xAxis.value,
                    upDelta: upDelta,
                    mouseDeltaX: gamepad.rightThumbstick.xAxis.value * 4,
                    mouseDeltaY: gamepad.rightThumbstick.yAxis.value * 4,
                    isMouseLeft: gamepad.leftShoulder.isPressed,
                    isMouseRight: gamepad.rightShoulder.isPressed
                )
            }
        }

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            return event.modifierFlags.contains(.command) ? event : nil
        }
    }

    func update(isMouseInView: Bool? = nil) {
        state = state.update(
            isMouseInView: wasGamepadInput || (isMouseInView ?? state.isMouseInView),
            mouseDeltaX: wasGamepadInput ? state.mouseDeltaX : 0,
            mouseDeltaY: wasGamepadInput ? state.mouseDeltaY : 0
        )
    }
}
