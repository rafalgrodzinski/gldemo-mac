//
//  ContentView.swift
//  glDemo
//
//  Created by Rafal on 20/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var configs = [GLView.Config](repeating: GLView.Config(), count: 3)
    
    var body: some View {
        HStack(spacing: 0) {
            GLViewWrapper(configs: configs)
                .background(Color.blue)
            TabView {
                ControlsView(config: $configs[0])
                    .tabItem { Label("1", systemImage: "01.circle") }
                ControlsView(config: $configs[1])
                    .tabItem { Label("2", systemImage: "02.circle") }
                ControlsView(config: $configs[2])
                    .tabItem { Label("3", systemImage: "03.circle") }
            }.frame(width: 200)
        }
    }
}

private struct ControlsView: View {
    @Binding var config: GLView.Config

    var body: some View {
        VStack(spacing: 8) {
            //Translate
            ZStack(alignment: .topLeading) {
                VStack(spacing: 8) {
                    Slider(
                        value: Binding(
                            get: { config.tx },
                            set: { config = config.updated(tx: $0) }
                        ),
                        in: GLView.Config.tRange
                    ) { Text("X") }

                    Slider(
                        value: Binding(
                            get: { config.ty },
                            set: { config = config.updated(ty: $0) }
                        ),
                        in: GLView.Config.tRange
                    ) { Text("Y") }

                    Slider(
                        value: Binding(
                            get: { config.tz },
                            set: { config = config.updated(tz: $0) }
                        ),
                        in: GLView.Config.tRange
                    ) { Text("Z") }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1)
                }.padding(.top, 8)
                Text("Translation")
                    .padding(.horizontal, 16)
            }

            // Rotate
            ZStack(alignment: .topLeading) {
                VStack(spacing: 8) {
                    Slider(
                        value: Binding(
                            get: { config.rx },
                            set: { config = config.updated(rx: $0) }
                        ),
                        in: GLView.Config.rRange
                    ) { Text("X") }

                    Slider(
                        value: Binding(
                            get: { config.ry },
                            set: { config = config.updated(ry: $0) }
                        ),
                        in: GLView.Config.rRange
                    ) { Text("Y") }

                    Slider(
                        value: Binding(
                            get: { config.rz },
                            set: { config = config.updated(rz: $0) }
                        ),
                        in: GLView.Config.rRange
                    ) { Text("Z") }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1)
                }.padding(.top, 8)
                Text("Rotation")
                    .padding(.horizontal, 16)
            }

            // Scale
            ZStack(alignment: .topLeading) {
                VStack(spacing: 8) {
                    Slider(
                        value: Binding(
                            get: { config.sx },
                            set: { config = config.updated(sx: $0) }
                        ),
                        in: GLView.Config.sRange
                    ) { Text("X") }

                    Slider(
                        value: Binding(
                            get: { config.sy },
                            set: { config = config.updated(sy: $0) }
                        ),
                        in: GLView.Config.sRange
                    ) { Text("Y") }

                    Slider(
                        value: Binding(
                            get: { config.sz },
                            set: { config = config.updated(sz: $0) }
                        ),
                        in: GLView.Config.sRange
                    ) { Text("Z") }

                    Slider(
                        value: Binding(
                            get: { max(config.sx, config.sy, config.sz) },
                            set: {
                                config = config.updated(sx: $0, sy: $0, sz: $0)
                            }
                        ),
                        in: GLView.Config.sRange
                    ) { Text("XYZ") }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1)
                }.padding(.top, 8)
                Text("Scale")
                    .padding(.horizontal, 16)
            }
        }
        .padding(8)
        .frame(width: 200)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
