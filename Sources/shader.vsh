//
//  shader.vsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

layout (location=0) in vec3 a_position;
layout (location=1) in vec2 a_textureCoords;

uniform mat4 u_projectionMatrix;
uniform mat4 u_modelviewMatrix;

out vec2 v_textureCoords;

void main(void) {
    gl_Position = u_projectionMatrix * u_modelviewMatrix * vec4(a_position, 1.0);
    v_textureCoords = a_textureCoords;
}
