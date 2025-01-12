//
//  GridShader.fsh
//  glDemo
//
//  Created by Rafał on 2025/01/03.
//

#version 410 core

in vec3 v_position;

out vec4 o_color;

/*float gridTextureGradBox( in vec2 p, in vec2 ddx, in vec2 ddy )
{
    // filter kernel
    vec2 w = max(abs(ddx), abs(ddy)) + 0.01;

    // analytic (box) filtering
    vec2 a = p + 0.5*w;
    vec2 b = p - 0.5*w;
    vec2 i = (floor(a)+min(fract(a)*N,1.0)-
              floor(b)-min(fract(b)*N,1.0))/(N*w);
    //pattern
    return (1.0-i.x)*(1.0-i.y);
}*/

void main() {
    //float a = dFdy(v_position.z);
    //o_color = vec4(a, a, a, 1);
    /*vec2 n = mod(v_position.xz, 1);
    float n2 = length(n);
    float nx = dFdx(n2);
    float ny = dFdy(n2);
    float nl = length(vec2(nx, ny));


    float a = mix(nl, 0, 1 - v_position.z);
    o_color = vec4(1, 1, 1, a);*/

    vec3 color = vec3(1, 1, 1);
    if (v_position.x > -0.1 && v_position.x < 0.1) {
        color = vec3(0, 0, 1);
    } else if (v_position.z > -0.1 && v_position.z < 0.1) {
        color = vec3(1, 0, 0);
    }

    o_color = vec4(color, 1);
}

/*void main() {
    float gridCellSize = 1;

    //vec2 dvy = vec2(dFdx(v_position.z), dFdy(v_position.z));

    //float lod = mod(v_position.z, 0.1) / (4 * dFdy(-v_position.z));
    vec2 dvx = vec2(dFdx(v_position.x), dFdy(v_position.x));
    vec2 dvz = vec2(dFdx(v_position.z), dFdy(v_position.z));

    float lengthX = length(dvx);
    float lengthZ = length(dvz);

    //float ly = length(dvy);
    //float lod = mod(v_position.z, 0.1) / (4 * ly);

    vec2 dudv = vec2(lengthX, lengthZ);

    float lod = max(0, log(length(dudv) * 4 / girdCellSize) + 1);

    float gridCellSizeLod0 = girdCellSize * pow(10, floor(lod));
    float gridCellSizeLod1 = gridCellSizeLod0 * 10;
    float gridCellSizeLod2 = gridCellSizeLod1 * 10;

    dudv *= 4;

    vec2 v2 = vec2(1) - mod(v_position.xz, gridCellSize) / dudv;
    float alpha = max(v2.x, v2.y);

    vec4 color = vec4(1, 1, 1, 1);
    color.a *= alpha;

    o_color = color;
}*/
