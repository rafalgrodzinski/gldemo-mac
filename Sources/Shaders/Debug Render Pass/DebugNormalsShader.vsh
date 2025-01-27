//
//  NormalsDebugShader.vsh
//  glDemo
//
//  Created by Rafał on 2025/01/01.
//

#version 410 core

layout (location=0) in vec3 a_position;
layout (location=1) in vec3 a_nextPosition;
layout (location=2) in vec3 a_normal;
layout (location=3) in vec3 a_nextNormal;

uniform mat4 u_projectionMatrix;
uniform mat4 u_viewMatrix;
uniform mat4 u_modelMatrix;
uniform float u_tweenFactor;

out vec4 v_normal;

void main() {
    vec3 position = mix(a_position, a_nextPosition, u_tweenFactor);
    gl_Position = u_projectionMatrix * u_viewMatrix * u_modelMatrix * vec4(position, 1);

    vec3 normal = mix(a_normal, a_nextNormal, u_tweenFactor);
    v_normal = u_projectionMatrix * u_viewMatrix * u_modelMatrix * vec4(position + normal, 1);
}
