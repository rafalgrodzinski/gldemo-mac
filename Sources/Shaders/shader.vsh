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
layout (location=3) in vec3 a_normal;

uniform mat4 u_projectionMatrix;
uniform mat4 u_modelMatrix;

out vec3 v_color;
out vec2 v_coords;
out vec3 v_normal;
out vec3 v_position;

void main(void) {
    gl_Position = u_projectionMatrix * u_modelMatrix * vec4(a_position, 1.0);
    v_color = a_color;
    v_coords = a_coords;
    v_normal = mat3(u_modelMatrix) * a_normal;
    v_position = vec3(u_modelMatrix * vec4(a_position, 1.0));
}
