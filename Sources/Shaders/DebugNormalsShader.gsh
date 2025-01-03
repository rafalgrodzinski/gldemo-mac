//
//  NormalsDebugShader.gsh
//  glDemo
//
//  Created by Rafał on 2025/01/01.
//

#version 410 core

layout (triangles) in;
layout (line_strip, max_vertices=2) out;

in vec4 v_normal[];

void main() {
    // Per triangle average normal
    gl_Position = (gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position) / 3;
    EmitVertex();

    gl_Position = (v_normal[0] + v_normal[1] + v_normal[2]) / 3;
    EmitVertex();

    EndPrimitive();
}
