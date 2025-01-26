//
//  DebugPolygonShader.gsh
//  glDemo
//
//  Created by Rafał on 2025/01/01.
//

#version 410 core

layout (triangles) in;
layout (line_strip, max_vertices=6) out;

void main() {
    // Edge 0
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    EndPrimitive();

    // Edge 1
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();

    // Edge 2
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    EndPrimitive();
}
