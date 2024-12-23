//
//  shader.fsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

//in vec2 v_textureCoords;
//uniform sampler2D sampler;

in vec3 v_color;

out vec4 color;

void main(void) {
    //color = texture(sampler, v_textureCoords);
    //color = vec4(1, 0, 0, 1);
    color = vec4(v_color, 1.0) * 0.5 + 0.6;
}
