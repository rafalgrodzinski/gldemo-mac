//
//  GridShaderFragment.glsl
//  glDemo
//
//  Created by Rafał on 2025/01/23.
//

#version 410 core

out vec4 o_color;

in vec2 v_coords;

uniform sampler2D u_samplerCoarse;
uniform sampler2D u_samplerDetailed;

void main() {
    vec4 coarseColor = texture(u_samplerCoarse, v_coords);
    coarseColor.rgb *= 4;
    coarseColor.a *= 2;

    vec4 detailedColor = texture(u_samplerDetailed, v_coords);

    o_color = mix(coarseColor, detailedColor, 1 - coarseColor.a);
}
