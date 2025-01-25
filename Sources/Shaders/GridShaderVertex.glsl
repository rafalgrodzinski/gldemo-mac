//
//  GridShaderVertex.glsl
//  glDemo
//
//  Created by Rafał on 2025/01/23.
//

#version 410 core

layout (location=0) in vec3 a_position;

uniform mat4 u_projectionMatrix;
uniform mat4 u_viewMatrix;
uniform vec3 u_cameraPosition;

out vec2 v_coords;

void main() {
    float scale = 100;

    vec3 position = vec3(a_position.x * scale + u_cameraPosition.x, 0, a_position.z * scale + u_cameraPosition.z);
    v_coords = position.xz;
    gl_Position = u_projectionMatrix * u_viewMatrix * vec4(position, 1);
}
