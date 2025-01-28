//
//  SkyboxFragment.glsl
//  glDemo
//
//  Created by Rafał on 2025/01/28.
//

#version 410 core

in vec3 v_coords;

uniform samplerCube u_sampler;

out vec4 o_color;

void main() {
    o_color = texture(u_sampler, v_coords);
}
