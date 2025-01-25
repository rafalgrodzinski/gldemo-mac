//
//  GridShaderFragment.glsl
//  glDemo
//
//  Created by Rafał on 2025/01/23.
//

#version 410 core

out vec4 o_color;

in vec2 v_coordsLevel0;
in vec2 v_coordsLevel1;
in vec2 v_coordsLevel2;

uniform sampler2D u_sampler;

void main() {
    vec4 color;

    vec4 level0Color = texture(u_sampler, v_coordsLevel0);
    level0Color *= 4;
    level0Color.a = clamp(level0Color.a, 0, 0.75);
    color = level0Color;

    vec4 level1Color = texture(u_sampler, v_coordsLevel1);
    level1Color *= 4;
    level1Color.a = clamp(level1Color.a, 0, 0.75);
    color = mix(color, level1Color, 1 - color.a);

    vec4 level2Color = texture(u_sampler, v_coordsLevel2);
    level2Color *= 4;
    level2Color.a = clamp(level2Color.a, 0, 0.75);
    color = mix(color, level2Color, 1 - color.a);

    o_color = color;
}
