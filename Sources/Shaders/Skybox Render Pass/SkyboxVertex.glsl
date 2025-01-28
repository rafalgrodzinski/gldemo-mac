//
//  SkyboxVertex.glsl
//  glDemo
//
//  Created by Rafał on 2025/01/28.
//

#version 410 core

layout (location=0) in vec3 a_position;

uniform mat4 u_projectionMatrix;
uniform mat4 u_viewMatrix;

out vec3 v_coords;

void main() {
    v_coords = vec3(a_position.x, a_position.y, -a_position.z);

    vec4 position = u_projectionMatrix * mat4(mat3(u_viewMatrix)) * vec4(a_position, 1);
    gl_Position = position.xyww;
}
