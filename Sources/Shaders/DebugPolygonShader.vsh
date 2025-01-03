//
//  DebugPolygonShader.vsh
//  glDemo
//
//  Created by Rafał on 2025/01/01.
//

#version 410 core

layout (location=0) in vec3 a_position;
layout (location=1) in vec3 a_nextPosition;

uniform mat4 u_projectionMatrix;
uniform mat4 u_viewMatrix;
uniform mat4 u_modelMatrix;
uniform float u_tweenFactor;

void main() {
    vec3 position = mix(a_position, a_nextPosition, u_tweenFactor);
    gl_Position = u_projectionMatrix * u_viewMatrix * u_modelMatrix * vec4(position, 1.0);
}
