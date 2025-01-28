//
//  ContentView.swift
//  glDemo
//
//  Created by Rafal on 20/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var config = Config()

    var body: some View {
        HStack(spacing: 0) {
            GLViewWrapper(config: config)
                .background(Color.blue)
            VStack(spacing: 8) {
                ZStack(alignment: .topLeading) {
                    VStack(spacing: 8) {
                        Toggle("Grid", isOn: Binding(
                            get: { config.sceneConfig.isGridOn },
                            set: { config.sceneConfig = config.sceneConfig.updated(isGridOn: $0) }
                        )).frame(maxWidth: .infinity, alignment: .leading)
                        Toggle("Axes", isOn: Binding(
                            get: { config.sceneConfig.isAxesOn },
                            set: { config.sceneConfig = config.sceneConfig.updated(isAxesOn: $0) }
                        )).frame(maxWidth: .infinity, alignment: .leading)
                        Toggle("Normals", isOn: Binding(
                            get: { config.sceneConfig.isNormalsOn },
                            set: { config.sceneConfig = config.sceneConfig.updated(isNormalsOn: $0) }
                        )).frame(maxWidth: .infinity, alignment: .leading)
                        Toggle("Mesh", isOn: Binding(
                            get: { config.sceneConfig.isMeshOn },
                            set: { config.sceneConfig = config.sceneConfig.updated(isMeshOn: $0) }
                        )).frame(maxWidth: .infinity, alignment: .leading)
                        Toggle("Skybox", isOn: Binding(
                            get: { config.sceneConfig.isSkyboxOn },
                            set: { config.sceneConfig = config.sceneConfig.updated(isSkyboxOn: $0) }
                        )).frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1)
                    }.padding(.top, 8)
                    Text("Scene")
                        .padding(.horizontal, 16)
                }.padding(8)

                TabView {
                    ControlsView(modelConfig: $config.modelConfigs[0])
                        .tabItem { Label("1", systemImage: "01.circle") }
                    ControlsView(modelConfig: $config.modelConfigs[1])
                        .tabItem { Label("2", systemImage: "02.circle") }
                    ControlsView(modelConfig: $config.modelConfigs[2])
                        .tabItem { Label("3", systemImage: "03.circle") }
                }
            }.frame(width: 200)
        }
    }
}

private struct ControlsView: View {
    @Binding var modelConfig: Config.ModelConfig

    var body: some View {
        VStack(spacing: 8) {
            //Translate
            ZStack(alignment: .topLeading) {
                VStack(spacing: 8) {
                    Slider(
                        value: Binding(
                            get: { modelConfig.tx },
                            set: { modelConfig = modelConfig.updated(tx: $0) }
                        ),
                        in: Config.ModelConfig.translationRange
                    ) { Text("X") }

                    Slider(
                        value: Binding(
                            get: { modelConfig.ty },
                            set: { modelConfig = modelConfig.updated(ty: $0) }
                        ),
                        in: Config.ModelConfig.translationRange
                    ) { Text("Y") }

                    Slider(
                        value: Binding(
                            get: { modelConfig.tz },
                            set: { modelConfig = modelConfig.updated(tz: $0) }
                        ),
                        in: Config.ModelConfig.translationRange
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
                            get: { modelConfig.rx },
                            set: { modelConfig = modelConfig.updated(rx: $0) }
                        ),
                        in: Config.ModelConfig.rotationRange
                    ) { Text("X") }

                    Slider(
                        value: Binding(
                            get: { modelConfig.ry },
                            set: { modelConfig = modelConfig.updated(ry: $0) }
                        ),
                        in: Config.ModelConfig.rotationRange
                    ) { Text("Y") }

                    Slider(
                        value: Binding(
                            get: { modelConfig.rz },
                            set: { modelConfig = modelConfig.updated(rz: $0) }
                        ),
                        in: Config.ModelConfig.rotationRange
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
                            get: { modelConfig.sx },
                            set: { modelConfig = modelConfig.updated(sx: $0) }
                        ),
                        in: Config.ModelConfig.scaleRange
                    ) { Text("X") }

                    Slider(
                        value: Binding(
                            get: { modelConfig.sy },
                            set: { modelConfig = modelConfig.updated(sy: $0) }
                        ),
                        in: Config.ModelConfig.scaleRange
                    ) { Text("Y") }

                    Slider(
                        value: Binding(
                            get: { modelConfig.sz },
                            set: { modelConfig = modelConfig.updated(sz: $0) }
                        ),
                        in: Config.ModelConfig.scaleRange
                    ) { Text("Z") }

                    Slider(
                        value: Binding(
                            get: { max(modelConfig.sx, modelConfig.sy, modelConfig.sz) },
                            set: {
                                modelConfig = modelConfig.updated(sx: $0, sy: $0, sz: $0)
                            }
                        ),
                        in: Config.ModelConfig.scaleRange
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
