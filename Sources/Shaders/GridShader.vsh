//
//  GridShader.vsh
//  glDemo
//
//  Created by Rafał on 2025/01/03.
//

#version 410 core

layout (location=0) in vec3 a_position;

uniform mat4 u_projectionMatrix;
uniform mat4 u_viewMatrix;

void main() {
    gl_Position = u_projectionMatrix * u_viewMatrix * vec4(a_position, 1);
}
