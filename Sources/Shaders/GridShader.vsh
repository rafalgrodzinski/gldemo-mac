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
uniform vec3 u_cameraPosition;

out vec3 v_position;

void main() {
    vec3 position = vec3(a_position.x * 1000 + u_cameraPosition.x, a_position.y * 1000, a_position.z * 1000 + u_cameraPosition.z);
    gl_Position = u_projectionMatrix * u_viewMatrix * vec4(position, 1);

    v_position = position;
}
