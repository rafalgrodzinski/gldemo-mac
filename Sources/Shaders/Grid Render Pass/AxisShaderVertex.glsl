//
//  AxisShaderVertex.glsl
//  glDemo
//
//  Created by Rafał on 2025/01/25.
//

#version 410 core

layout (location=0) in vec3 a_position;

uniform mat4 u_projectionMatrix;
uniform mat4 u_viewMatrix;

void main() {
    float scale = 1000;

    gl_Position = u_projectionMatrix * u_viewMatrix * vec4(a_position * scale, 1);
}
