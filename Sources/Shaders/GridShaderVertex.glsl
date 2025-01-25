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

out vec2 v_coordsLevel0;
out vec2 v_coordsLevel1;
out vec2 v_coordsLevel2;

void main() {
    float scale = 1000;

    vec3 position = vec3(a_position.x * scale + u_cameraPosition.x, 0, a_position.z * scale + u_cameraPosition.z);
    v_coordsLevel0 = position.xz / 10;
    v_coordsLevel1 = position.xz;
    v_coordsLevel2 = position.xz * 10;
    gl_Position = u_projectionMatrix * u_viewMatrix * vec4(position, 1);
}
