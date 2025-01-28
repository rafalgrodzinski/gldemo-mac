//
//  Config.swift
//  glDemo
//
//  Created by Rafał on 2025/01/26.
//

import Foundation

struct Config {
    struct SceneConfig {
        let isGridOn: Bool
        let isAxesOn: Bool
        let isNormalsOn: Bool
        let isMeshOn: Bool
        let isSkyboxOn: Bool

        init(isGridOn: Bool? = nil, isAxesOn: Bool? = nil, isNormalsOn: Bool? = nil, isMeshOn: Bool? = nil, isSkyboxOn: Bool? = nil) {
            self.isGridOn = isGridOn ?? true
            self.isAxesOn = isAxesOn ?? true
            self.isNormalsOn = isNormalsOn ?? false
            self.isMeshOn = isMeshOn ?? false
            self.isSkyboxOn = isSkyboxOn ?? false
        }

        func updated(isGridOn: Bool? = nil, isAxesOn: Bool? = nil, isNormalsOn: Bool? = nil, isMeshOn: Bool? = nil, isSkyboxOn: Bool? = nil) -> SceneConfig {
            SceneConfig(
                isGridOn: isGridOn ?? self.isGridOn,
                isAxesOn: isAxesOn ?? self.isAxesOn,
                isNormalsOn: isNormalsOn ?? self.isNormalsOn,
                isMeshOn: isMeshOn ?? self.isMeshOn,
                isSkyboxOn: isSkyboxOn ?? self.isSkyboxOn
            )
        }
     }

    struct ModelConfig {
        static let translationRange: ClosedRange<Float> = -100...100
        static let rotationRange: ClosedRange<Float> = -180...180
        static let scaleRange: ClosedRange<Float> = 0.1...10

        let tx: Float
        let ty: Float
        let tz: Float

        let rx: Float
        let ry: Float
        let rz: Float

        let sx: Float
        let sy: Float
        let sz: Float

        init(
            tx: Float? = nil, ty: Float? = nil, tz: Float? = nil,
            rx: Float? = nil, ry: Float? = nil, rz: Float? = nil,
            sx: Float? = nil, sy: Float? = nil, sz: Float? = nil
        ) {
            self.tx = tx ?? 0
            self.ty = ty ?? 0
            self.tz = tz ?? 0

            self.rx = rx ?? 0
            self.ry = ry ?? 0
            self.rz = rz ?? 0

            self.sx = sx ?? 1
            self.sy = sy ?? 1
            self.sz = sz ?? 1
        }

        func updated(
            tx: Float? = nil, ty: Float? = nil, tz: Float? = nil,
            rx: Float? = nil, ry: Float? = nil, rz: Float? = nil,
            sx: Float? = nil, sy: Float? = nil, sz: Float? = nil
        ) -> ModelConfig {
            ModelConfig(
                tx: tx ?? self.tx, ty: ty ?? self.ty, tz: tz ?? self.tz,
                rx: rx ?? self.rx, ry: ry ?? self.ry, rz: rz ?? self.rz,
                sx: sx ?? self.sx, sy: sy ?? self.sy, sz: sz ?? self.sz
            )
        }
    }

    var sceneConfig = SceneConfig()
    var modelConfigs = [ModelConfig](repeating: ModelConfig(), count: 3)
}
