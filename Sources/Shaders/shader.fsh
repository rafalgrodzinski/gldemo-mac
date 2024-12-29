//
//  shader.fsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

struct Light {
    vec3 color;
    float intensity;
    vec3 direction;
};

in vec3 v_position;
in vec3 v_normal;
in vec3 v_color;
in vec2 v_coords;
in float v_ambient;
in float v_diffuse;
in float v_specular;

uniform sampler2D u_sampler;
uniform Light u_light;
uniform vec3 u_cameraPosition;

out vec4 o_color;

vec3 directionalLightColor(vec3 position, vec3 normal, vec3 baseColor, Light light, vec3 cameraPosition, float ambient, float diffuse, float specular) {
    vec3 color = vec3(0);

    // Ambient
    float ambientIntensity = light.intensity * ambient;
    ambientIntensity = clamp(ambientIntensity, 0.0, 1.0);
    color += baseColor * light.color * ambientIntensity;

    // Diffuse
    float diffuseIntensity = dot(normal, -light.direction) * light.intensity * diffuse;
    diffuseIntensity = clamp(diffuseIntensity, 0.0, 1.0 - ambientIntensity);
    color += baseColor * light.color * diffuseIntensity;

    // Specular
    vec3 cameraDirection = normalize(cameraPosition - position);
    vec3 halfv = normalize(cameraDirection + light.direction);
    float specularIntensity = dot(normal, -halfv);
    specularIntensity = clamp(specularIntensity, 0.0, 1.0);
    color += light.color * pow(specularIntensity, specular) * light.intensity;

    return color;
}

void main(void) {
    vec3 baseColor = vec3(texture(u_sampler, v_coords)) * v_color;
    o_color = vec4(directionalLightColor(v_position, v_normal, baseColor, u_light, u_cameraPosition, v_ambient, v_diffuse, v_specular), 1.0);
}
