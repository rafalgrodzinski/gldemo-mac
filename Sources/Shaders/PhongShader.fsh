//
//  shader.fsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

const int LightKindUnused = 0;
const int LightKindDirectional = 1;
const int LightKindPoint = 2;


struct Light {
    int kind;
    vec3 color; // all
    float intensity; // directional
    float linearAttenuation; // point
    float quadraticAttenuation; // point
    vec3 direction; // directional
    vec3 position; // point
};

in vec3 v_position;
in vec3 v_normal;
in vec3 v_color;
in vec2 v_coords;
in float v_ambient;
in float v_diffuse;
in float v_specular;

uniform sampler2D u_sampler;
uniform Light u_lights[8];
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

vec3 pointLightColor(vec3 position, vec3 normal, vec3 baseColor, Light light, vec3 cameraPosition, float ambient, float diffuse, float specular) {
    vec3 color = vec3(0);

    // Ambient
    float ambientIntensity = light.intensity * ambient;
    ambientIntensity = clamp(ambientIntensity, 0.0, 1.0);
    color += baseColor * light.color * ambientIntensity;

    // Diffuse
    float distance = length(light.position - position);
    float attenuation = 1.0 / (1 + light.linearAttenuation * distance + light.quadraticAttenuation * distance * distance);
    vec3 direction = normalize(light.position - position);
    float diffuseIntensity = dot(normal, -direction) * attenuation;
    diffuseIntensity = clamp(diffuseIntensity, 0.0, 1.0 - ambientIntensity);
    color += baseColor * light.color * diffuseIntensity;

    return color;
}

void main() {
    vec3 baseColor = vec3(texture(u_sampler, v_coords)) * v_color;
    vec3 color = vec3(0);

    vec3 n = v_normal;

    vec3 nor = normalize(cross(dFdx(v_position), dFdy(v_position)));

    for(int i=0; i<8; i++) {
        if (u_lights[i].kind == LightKindDirectional) {
            color += directionalLightColor(v_position, nor, baseColor, u_lights[i], u_cameraPosition, v_ambient, v_diffuse, v_specular);
        } else if(u_lights[i].kind == LightKindPoint) {
            color += pointLightColor(v_position, nor, baseColor, u_lights[i], u_cameraPosition, v_ambient, v_diffuse, v_specular);
        }
    }

    o_color = vec4(color, 1.0);
}
