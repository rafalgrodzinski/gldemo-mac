//
//  ContentView.swift
//  glDemo
//
//  Created by Rafal on 20/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var config = GLView.Config()

    var body: some View {
        HStack(spacing: 0) {
            GLViewWrapper(config: config)
                .background(Color.blue)
            ControlsView(config: $config)
        }
    }
}

private struct ControlsView: View {
    @Binding var config: GLView.Config

    @State private var tx: Float = 0

    var body: some View {
        VStack(spacing: 8) {
            //Translate
            Slider(
                value: Binding(
                    get: { config.tx },
                    set: { config = config.updated(tx: $0) }
                ),
                in: GLView.Config.tRange
            ) { Text("TX") }

            Slider(
                value: Binding(
                    get: { config.ty },
                    set: { config = config.updated(ty: $0) }
                ),
                in: GLView.Config.tRange
            ) { Text("TY") }

            Slider(
                value: Binding(
                    get: { config.tz },
                    set: { config = config.updated(tz: $0) }
                ),
                in: GLView.Config.tRange
            ) { Text("TZ") }

            // Rotate
            Slider(
                value: Binding(
                    get: { config.rx },
                    set: { config = config.updated(rx: $0) }
                ),
                in: GLView.Config.rRange
            ) { Text("RX") }

            Slider(
                value: Binding(
                    get: { config.ry },
                    set: { config = config.updated(ry: $0) }
                ),
                in: GLView.Config.rRange
            ) { Text("RY") }

            Slider(
                value: Binding(
                    get: { config.rz },
                    set: { config = config.updated(rz: $0) }
                ),
                in: GLView.Config.rRange
            ) { Text("RZ") }
        }
        .padding(8)
        .frame(width: 200)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
