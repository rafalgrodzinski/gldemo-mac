//
//  shader.vsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

layout (location=0) in vec3 a_position;
layout (location=1) in vec3 a_nextPosition;
layout (location=2) in vec3 a_normal;
layout (location=3) in vec3 a_nextNormal;
layout (location=4) in vec3 a_color;
layout (location=5) in vec2 a_coords;
layout (location=6) in vec3 a_ambientDiffuseSpecular;

uniform mat4 u_projectionMatrix;
uniform mat4 u_viewMatrix;
uniform mat4 u_modelMatrix;
uniform float u_tweenFactor;

out vec3 v_position;
out vec3 v_normal;
out vec3 v_color;
out vec2 v_coords;
out float v_ambient;
out float v_diffuse;
out float v_specular;

void main() {
    vec3 position = mix(a_position, a_nextPosition, u_tweenFactor);
    gl_Position = u_projectionMatrix * u_viewMatrix * u_modelMatrix * vec4(position, 1.0);
    v_position = vec3(u_modelMatrix * vec4(position, 1.0));

    vec3 normal = mix(a_normal, a_nextNormal, u_tweenFactor);
    v_normal = mat3(u_modelMatrix) * normal;

    v_color = a_color;
    v_coords = a_coords;
    v_ambient = a_ambientDiffuseSpecular.x;
    v_diffuse = a_ambientDiffuseSpecular.y;
    v_specular = a_ambientDiffuseSpecular.z;
}
