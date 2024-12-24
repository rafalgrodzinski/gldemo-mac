//
//  shader.vsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

layout (location=0) in vec3 a_position;
layout (location=1) in vec3 a_color;
layout (location=2) in vec2 a_coords;

uniform mat4 u_projectionMatrix;
uniform mat4 u_modelMatrix;

out vec3 v_color;
out vec2 v_coords;

void main(void) {
    gl_Position = u_projectionMatrix * u_modelMatrix * vec4(a_position, 1.0);
    v_color = a_color;
    v_coords = a_coords;
}
