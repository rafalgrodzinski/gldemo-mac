//
//  shader.fsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

struct Light {
    vec3 direction;
    vec3 color;
    float ambientIntensity;
    float diffuseIntensity;
    float specularIntensity;
};

in vec3 v_color;
in vec2 v_coords;
in vec3 v_normal;
in vec3 v_position;

uniform Light u_light;
uniform sampler2D u_sampler;
uniform vec3 u_eyePosition;

out vec4 o_color;

vec3 directionalLightColor(vec3 baseColor, Light light) {
    vec3 color;

    // Ambient & Diffuse
    float intensity = dot(v_normal, -u_light.direction) * light.diffuseIntensity + light.ambientIntensity;
    intensity = clamp(intensity, 0.0, 1.0);
    color = baseColor * u_light.color * intensity;

    // Specular
    vec3 cameraDirection = normalize(vec3(0,0,0) - v_position);
    vec3 lightDirectionReflected = normalize(reflect(light.direction, v_normal));
    float specularIntensity = dot(cameraDirection, lightDirectionReflected) * light.specularIntensity;
    specularIntensity = clamp(specularIntensity, 0.0, 1.0);
    color += pow(specularIntensity, 8) * light.color;

    return color;
}

void main(void) {
    vec3 baseColor = vec3(texture(u_sampler, v_coords)) + v_color;
    o_color = vec4(directionalLightColor(baseColor, u_light), 1.0);
}
