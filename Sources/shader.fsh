//
//  shader.fsh
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

#version 410 core

in vec2 v_textureCoords;
uniform sampler2D sampler;

out vec4 color;

void main(void) {
    color = texture(sampler, v_textureCoords);
}
