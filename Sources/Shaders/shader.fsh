//
//  shader.fsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

in vec3 v_color;
in vec2 v_coords;

uniform sampler2D u_sampler;

out vec4 color;

void main(void) {
    color = texture(u_sampler, v_coords) + vec4(v_color, 1.0) * 0.1;
}
