//
//  AxisShaderFragment.glsl
//  glDemo
//
//  Created by Rafał on 2025/01/25.
//

#version 410 core

out vec4 o_color;

uniform int u_axisDirection;

void main() {
    if (u_axisDirection == 0) {
        o_color = vec4(1, 0, 0, 1);
    } else if (u_axisDirection == 1) {
        o_color = vec4(0, 1, 0, 1);
    } else if (u_axisDirection == 2) {
        o_color = vec4(0, 0, 1, 1);
    } else {
        discard;
    }
}
