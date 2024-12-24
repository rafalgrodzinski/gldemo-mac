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
    float diffuseIntensity;
    float ambientIntensity;
};

in vec3 v_color;
in vec2 v_coords;
in vec3 v_normal;

uniform Light u_light;
uniform sampler2D u_sampler;

out vec4 o_color;

vec3 directionalLightColor(vec3 baseColor, Light light) {
    float intensity = dot(v_normal, -u_light.direction) * light.diffuseIntensity + light.ambientIntensity;
    intensity = clamp(intensity, 0.0, 1.0);
    return baseColor * u_light.color * intensity;
}

void main(void) {
    vec3 baseColor = vec3(texture(u_sampler, v_coords)) + v_color;
    o_color = vec4(directionalLightColor(baseColor, u_light), 1.0);
}
