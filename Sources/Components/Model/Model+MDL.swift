//
//  Model+MDL.swift
//  glDemo
//
//  Created by Rafał on 2024/12/29.
//

import Foundation
import OpenGL.GL
import Cocoa

extension Model {
    private static let version = 6

    private static let normals = [
        (-0.525731,  0.000000,  0.850651),
        (-0.442863,  0.238856,  0.864188),
        (-0.295242,  0.000000,  0.955423),
        (-0.309017,  0.500000,  0.809017),
        (-0.162460,  0.262866,  0.951056),
        ( 0.000000,  0.000000,  1.000000),
        ( 0.000000,  0.850651,  0.525731),
        (-0.147621,  0.716567,  0.681718),
        ( 0.147621,  0.716567,  0.681718),
        ( 0.000000,  0.525731,  0.850651),
        ( 0.309017,  0.500000,  0.809017),
        ( 0.525731,  0.000000,  0.850651),
        ( 0.295242,  0.000000,  0.955423),
        ( 0.442863,  0.238856,  0.864188),
        ( 0.162460,  0.262866,  0.951056),
        (-0.681718,  0.147621,  0.716567),
        (-0.809017,  0.309017,  0.500000),
        (-0.587785,  0.425325,  0.688191),
        (-0.850651,  0.525731,  0.000000),
        (-0.864188,  0.442863,  0.238856),
        (-0.716567,  0.681718,  0.147621),
        (-0.688191,  0.587785,  0.425325),
        (-0.500000,  0.809017,  0.309017),
        (-0.238856,  0.864188,  0.442863),
        (-0.425325,  0.688191,  0.587785),
        (-0.716567,  0.681718, -0.147621),
        (-0.500000,  0.809017, -0.309017),
        (-0.525731,  0.850651,  0.000000),
        ( 0.000000,  0.850651, -0.525731),
        (-0.238856,  0.864188, -0.442863),
        ( 0.000000,  0.955423, -0.295242),
        (-0.262866,  0.951056, -0.162460),
        ( 0.000000,  1.000000,  0.000000),
        ( 0.000000,  0.955423,  0.295242),
        (-0.262866,  0.951056,  0.162460),
        ( 0.238856,  0.864188,  0.442863),
        ( 0.262866,  0.951056,  0.162460),
        ( 0.500000,  0.809017,  0.309017),
        ( 0.238856,  0.864188, -0.442863),
        ( 0.262866,  0.951056, -0.162460),
        ( 0.500000,  0.809017, -0.309017),
        ( 0.850651,  0.525731,  0.000000),
        ( 0.716567,  0.681718,  0.147621),
        ( 0.716567,  0.681718, -0.147621),
        ( 0.525731,  0.850651,  0.000000),
        ( 0.425325,  0.688191,  0.587785),
        ( 0.864188,  0.442863,  0.238856),
        ( 0.688191,  0.587785,  0.425325),
        ( 0.809017,  0.309017,  0.500000),
        ( 0.681718,  0.147621,  0.716567),
        ( 0.587785,  0.425325,  0.688191),
        ( 0.955423,  0.295242,  0.000000),
        ( 1.000000,  0.000000,  0.000000),
        ( 0.951056,  0.162460,  0.262866),
        ( 0.850651, -0.525731,  0.000000),
        ( 0.955423, -0.295242,  0.000000),
        ( 0.864188, -0.442863,  0.238856),
        ( 0.951056, -0.162460,  0.262866),
        ( 0.809017, -0.309017,  0.500000),
        ( 0.681718, -0.147621,  0.716567),
        ( 0.850651,  0.000000,  0.525731),
        ( 0.864188,  0.442863, -0.238856),
        ( 0.809017,  0.309017, -0.500000),
        ( 0.951056,  0.162460, -0.262866),
        ( 0.525731,  0.000000, -0.850651),
        ( 0.681718,  0.147621, -0.716567),
        ( 0.681718, -0.147621, -0.716567),
        ( 0.850651,  0.000000, -0.525731),
        ( 0.809017, -0.309017, -0.500000),
        ( 0.864188, -0.442863, -0.238856),
        ( 0.951056, -0.162460, -0.262866),
        ( 0.147621,  0.716567, -0.681718),
        ( 0.309017,  0.500000, -0.809017),
        ( 0.425325,  0.688191, -0.587785),
        ( 0.442863,  0.238856, -0.864188),
        ( 0.587785,  0.425325, -0.688191),
        ( 0.688191,  0.587785, -0.425325),
        (-0.147621,  0.716567, -0.681718),
        (-0.309017,  0.500000, -0.809017),
        ( 0.000000,  0.525731, -0.850651),
        (-0.525731,  0.000000, -0.850651),
        (-0.442863,  0.238856, -0.864188),
        (-0.295242,  0.000000, -0.955423),
        (-0.162460,  0.262866, -0.951056),
        ( 0.000000,  0.000000, -1.000000),
        ( 0.295242,  0.000000, -0.955423),
        ( 0.162460,  0.262866, -0.951056),
        (-0.442863, -0.238856, -0.864188),
        (-0.309017, -0.500000, -0.809017),
        (-0.162460, -0.262866, -0.951056),
        ( 0.000000, -0.850651, -0.525731),
        (-0.147621, -0.716567, -0.681718),
        ( 0.147621, -0.716567, -0.681718),
        ( 0.000000, -0.525731, -0.850651),
        ( 0.309017, -0.500000, -0.809017),
        ( 0.442863, -0.238856, -0.864188),
        ( 0.162460, -0.262866, -0.951056),
        ( 0.238856, -0.864188, -0.442863),
        ( 0.500000, -0.809017, -0.309017),
        ( 0.425325, -0.688191, -0.587785),
        ( 0.716567, -0.681718, -0.147621),
        ( 0.688191, -0.587785, -0.425325),
        ( 0.587785, -0.425325, -0.688191),
        ( 0.000000, -0.955423, -0.295242),
        ( 0.000000, -1.000000,  0.000000),
        ( 0.262866, -0.951056, -0.162460),
        ( 0.000000, -0.850651,  0.525731),
        ( 0.000000, -0.955423,  0.295242),
        ( 0.238856, -0.864188,  0.442863),
        ( 0.262866, -0.951056,  0.162460),
        ( 0.500000, -0.809017,  0.309017),
        ( 0.716567, -0.681718,  0.147621),
        ( 0.525731, -0.850651,  0.000000),
        (-0.238856, -0.864188, -0.442863),
        (-0.500000, -0.809017, -0.309017),
        (-0.262866, -0.951056, -0.162460),
        (-0.850651, -0.525731,  0.000000),
        (-0.716567, -0.681718, -0.147621),
        (-0.716567, -0.681718,  0.147621),
        (-0.525731, -0.850651,  0.000000),
        (-0.500000, -0.809017,  0.309017),
        (-0.238856, -0.864188,  0.442863),
        (-0.262866, -0.951056,  0.162460),
        (-0.864188, -0.442863,  0.238856),
        (-0.809017, -0.309017,  0.500000),
        (-0.688191, -0.587785,  0.425325),
        (-0.681718, -0.147621,  0.716567),
        (-0.442863, -0.238856,  0.864188),
        (-0.587785, -0.425325,  0.688191),
        (-0.309017, -0.500000,  0.809017),
        (-0.147621, -0.716567,  0.681718),
        (-0.425325, -0.688191,  0.587785),
        (-0.162460, -0.262866,  0.951056),
        ( 0.442863, -0.238856,  0.864188),
        ( 0.162460, -0.262866,  0.951056),
        ( 0.309017, -0.500000,  0.809017),
        ( 0.147621, -0.716567,  0.681718),
        ( 0.000000, -0.525731,  0.850651),
        ( 0.425325, -0.688191,  0.587785),
        ( 0.587785, -0.425325,  0.688191),
        ( 0.688191, -0.587785,  0.425325),
        (-0.955423,  0.295242,  0.000000),
        (-0.951056,  0.162460,  0.262866),
        (-1.000000,  0.000000,  0.000000),
        (-0.850651,  0.000000,  0.525731),
        (-0.955423, -0.295242,  0.000000),
        (-0.951056, -0.162460,  0.262866),
        (-0.864188,  0.442863, -0.238856),
        (-0.951056,  0.162460, -0.262866),
        (-0.809017,  0.309017, -0.500000),
        (-0.864188, -0.442863, -0.238856),
        (-0.951056, -0.162460, -0.262866),
        (-0.809017, -0.309017, -0.500000),
        (-0.681718,  0.147621, -0.716567),
        (-0.681718, -0.147621, -0.716567),
        (-0.850651,  0.000000, -0.525731),
        (-0.688191,  0.587785, -0.425325),
        (-0.587785,  0.425325, -0.688191),
        (-0.425325,  0.688191, -0.587785),
        (-0.425325, -0.688191, -0.587785),
        (-0.587785, -0.425325, -0.688191),
        (-0.688191, -0.587785, -0.425325)
    ]

    private static let palette = [
        (0x00, 0x00, 0x00),
        (0x0f, 0x0f, 0x0f),
        (0x1f, 0x1f, 0x1f),
        (0x2f, 0x2f, 0x2f),
        (0x3f, 0x3f, 0x3f),
        (0x4b, 0x4b, 0x4b),
        (0x5b, 0x5b, 0x5b),
        (0x6b, 0x6b, 0x6b),
        (0x7b, 0x7b, 0x7b),
        (0x8b, 0x8b, 0x8b),
        (0x9b, 0x9b, 0x9b),
        (0xab, 0xab, 0xab),
        (0xbb, 0xbb, 0xbb),
        (0xcb, 0xcb, 0xcb),
        (0xdb, 0xdb, 0xdb),
        (0xeb, 0xeb, 0xeb),
        (0x0f, 0x0b, 0x07),
        (0x17, 0x0f, 0x0b),
        (0x1f, 0x17, 0x0b),
        (0x27, 0x1b, 0x0f),
        (0x2f, 0x23, 0x13),
        (0x37, 0x2b, 0x17),
        (0x3f, 0x2f, 0x17),
        (0x4b, 0x37, 0x1b),
        (0x53, 0x3b, 0x1b),
        (0x5b, 0x43, 0x1f),
        (0x63, 0x4b, 0x1f),
        (0x6b, 0x53, 0x1f),
        (0x73, 0x57, 0x1f),
        (0x7b, 0x5f, 0x23),
        (0x83, 0x67, 0x23),
        (0x8f, 0x6f, 0x23),
        (0x0b, 0x0b, 0x0f),
        (0x13, 0x13, 0x1b),
        (0x1b, 0x1b, 0x27),
        (0x27, 0x27, 0x33),
        (0x2f, 0x2f, 0x3f),
        (0x37, 0x37, 0x4b),
        (0x3f, 0x3f, 0x57),
        (0x47, 0x47, 0x67),
        (0x4f, 0x4f, 0x73),
        (0x5b, 0x5b, 0x7f),
        (0x63, 0x63, 0x8b),
        (0x6b, 0x6b, 0x97),
        (0x73, 0x73, 0xa3),
        (0x7b, 0x7b, 0xaf),
        (0x83, 0x83, 0xbb),
        (0x8b, 0x8b, 0xcb),
        (0x00, 0x00, 0x00),
        (0x07, 0x07, 0x00),
        (0x0b, 0x0b, 0x00),
        (0x13, 0x13, 0x00),
        (0x1b, 0x1b, 0x00),
        (0x23, 0x23, 0x00),
        (0x2b, 0x2b, 0x07),
        (0x2f, 0x2f, 0x07),
        (0x37, 0x37, 0x07),
        (0x3f, 0x3f, 0x07),
        (0x47, 0x47, 0x07),
        (0x4b, 0x4b, 0x0b),
        (0x53, 0x53, 0x0b),
        (0x5b, 0x5b, 0x0b),
        (0x63, 0x63, 0x0b),
        (0x6b, 0x6b, 0x0f),
        (0x07, 0x00, 0x00),
        (0x0f, 0x00, 0x00),
        (0x17, 0x00, 0x00),
        (0x1f, 0x00, 0x00),
        (0x27, 0x00, 0x00),
        (0x2f, 0x00, 0x00),
        (0x37, 0x00, 0x00),
        (0x3f, 0x00, 0x00),
        (0x47, 0x00, 0x00),
        (0x4f, 0x00, 0x00),
        (0x57, 0x00, 0x00),
        (0x5f, 0x00, 0x00),
        (0x67, 0x00, 0x00),
        (0x6f, 0x00, 0x00),
        (0x77, 0x00, 0x00),
        (0x7f, 0x00, 0x00),
        (0x13, 0x13, 0x00),
        (0x1b, 0x1b, 0x00),
        (0x23, 0x23, 0x00),
        (0x2f, 0x2b, 0x00),
        (0x37, 0x2f, 0x00),
        (0x43, 0x37, 0x00),
        (0x4b, 0x3b, 0x07),
        (0x57, 0x43, 0x07),
        (0x5f, 0x47, 0x07),
        (0x6b, 0x4b, 0x0b),
        (0x77, 0x53, 0x0f),
        (0x83, 0x57, 0x13),
        (0x8b, 0x5b, 0x13),
        (0x97, 0x5f, 0x1b),
        (0xa3, 0x63, 0x1f),
        (0xaf, 0x67, 0x23),
        (0x23, 0x13, 0x07),
        (0x2f, 0x17, 0x0b),
        (0x3b, 0x1f, 0x0f),
        (0x4b, 0x23, 0x13),
        (0x57, 0x2b, 0x17),
        (0x63, 0x2f, 0x1f),
        (0x73, 0x37, 0x23),
        (0x7f, 0x3b, 0x2b),
        (0x8f, 0x43, 0x33),
        (0x9f, 0x4f, 0x33),
        (0xaf, 0x63, 0x2f),
        (0xbf, 0x77, 0x2f),
        (0xcf, 0x8f, 0x2b),
        (0xdf, 0xab, 0x27),
        (0xef, 0xcb, 0x1f),
        (0xff, 0xf3, 0x1b),
        (0x0b, 0x07, 0x00),
        (0x1b, 0x13, 0x00),
        (0x2b, 0x23, 0x0f),
        (0x37, 0x2b, 0x13),
        (0x47, 0x33, 0x1b),
        (0x53, 0x37, 0x23),
        (0x63, 0x3f, 0x2b),
        (0x6f, 0x47, 0x33),
        (0x7f, 0x53, 0x3f),
        (0x8b, 0x5f, 0x47),
        (0x9b, 0x6b, 0x53),
        (0xa7, 0x7b, 0x5f),
        (0xb7, 0x87, 0x6b),
        (0xc3, 0x93, 0x7b),
        (0xd3, 0xa3, 0x8b),
        (0xe3, 0xb3, 0x97),
        (0xab, 0x8b, 0xa3),
        (0x9f, 0x7f, 0x97),
        (0x93, 0x73, 0x87),
        (0x8b, 0x67, 0x7b),
        (0x7f, 0x5b, 0x6f),
        (0x77, 0x53, 0x63),
        (0x6b, 0x4b, 0x57),
        (0x5f, 0x3f, 0x4b),
        (0x57, 0x37, 0x43),
        (0x4b, 0x2f, 0x37),
        (0x43, 0x27, 0x2f),
        (0x37, 0x1f, 0x23),
        (0x2b, 0x17, 0x1b),
        (0x23, 0x13, 0x13),
        (0x17, 0x0b, 0x0b),
        (0x0f, 0x07, 0x07),
        (0xbb, 0x73, 0x9f),
        (0xaf, 0x6b, 0x8f),
        (0xa3, 0x5f, 0x83),
        (0x97, 0x57, 0x77),
        (0x8b, 0x4f, 0x6b),
        (0x7f, 0x4b, 0x5f),
        (0x73, 0x43, 0x53),
        (0x6b, 0x3b, 0x4b),
        (0x5f, 0x33, 0x3f),
        (0x53, 0x2b, 0x37),
        (0x47, 0x23, 0x2b),
        (0x3b, 0x1f, 0x23),
        (0x2f, 0x17, 0x1b),
        (0x23, 0x13, 0x13),
        (0x17, 0x0b, 0x0b),
        (0x0f, 0x07, 0x07),
        (0xdb, 0xc3, 0xbb),
        (0xcb, 0xb3, 0xa7),
        (0xbf, 0xa3, 0x9b),
        (0xaf, 0x97, 0x8b),
        (0xa3, 0x87, 0x7b),
        (0x97, 0x7b, 0x6f),
        (0x87, 0x6f, 0x5f),
        (0x7b, 0x63, 0x53),
        (0x6b, 0x57, 0x47),
        (0x5f, 0x4b, 0x3b),
        (0x53, 0x3f, 0x33),
        (0x43, 0x33, 0x27),
        (0x37, 0x2b, 0x1f),
        (0x27, 0x1f, 0x17),
        (0x1b, 0x13, 0x0f),
        (0x0f, 0x0b, 0x07),
        (0x6f, 0x83, 0x7b),
        (0x67, 0x7b, 0x6f),
        (0x5f, 0x73, 0x67),
        (0x57, 0x6b, 0x5f),
        (0x4f, 0x63, 0x57),
        (0x47, 0x5b, 0x4f),
        (0x3f, 0x53, 0x47),
        (0x37, 0x4b, 0x3f),
        (0x2f, 0x43, 0x37),
        (0x2b, 0x3b, 0x2f),
        (0x23, 0x33, 0x27),
        (0x1f, 0x2b, 0x1f),
        (0x17, 0x23, 0x17),
        (0x0f, 0x1b, 0x13),
        (0x0b, 0x13, 0x0b),
        (0x07, 0x0b, 0x07),
        (0xff, 0xf3, 0x1b),
        (0xef, 0xdf, 0x17),
        (0xdb, 0xcb, 0x13),
        (0xcb, 0xb7, 0x0f),
        (0xbb, 0xa7, 0x0f),
        (0xab, 0x97, 0x0b),
        (0x9b, 0x83, 0x07),
        (0x8b, 0x73, 0x07),
        (0x7b, 0x63, 0x07),
        (0x6b, 0x53, 0x00),
        (0x5b, 0x47, 0x00),
        (0x4b, 0x37, 0x00),
        (0x3b, 0x2b, 0x00),
        (0x2b, 0x1f, 0x00),
        (0x1b, 0x0f, 0x00),
        (0x0b, 0x07, 0x00),
        (0x00, 0x00, 0xff),
        (0x0b, 0x0b, 0xef),
        (0x13, 0x13, 0xdf),
        (0x1b, 0x1b, 0xcf),
        (0x23, 0x23, 0xbf),
        (0x2b, 0x2b, 0xaf),
        (0x2f, 0x2f, 0x9f),
        (0x2f, 0x2f, 0x8f),
        (0x2f, 0x2f, 0x7f),
        (0x2f, 0x2f, 0x6f),
        (0x2f, 0x2f, 0x5f),
        (0x2b, 0x2b, 0x4f),
        (0x23, 0x23, 0x3f),
        (0x1b, 0x1b, 0x2f),
        (0x13, 0x13, 0x1f),
        (0x0b, 0x0b, 0x0f),
        (0x2b, 0x00, 0x00),
        (0x3b, 0x00, 0x00),
        (0x4b, 0x07, 0x00),
        (0x5f, 0x07, 0x00),
        (0x6f, 0x0f, 0x00),
        (0x7f, 0x17, 0x07),
        (0x93, 0x1f, 0x07),
        (0xa3, 0x27, 0x0b),
        (0xb7, 0x33, 0x0f),
        (0xc3, 0x4b, 0x1b),
        (0xcf, 0x63, 0x2b),
        (0xdb, 0x7f, 0x3b),
        (0xe3, 0x97, 0x4f),
        (0xe7, 0xab, 0x5f),
        (0xef, 0xbf, 0x77),
        (0xf7, 0xd3, 0x8b),
        (0xa7, 0x7b, 0x3b),
        (0xb7, 0x9b, 0x37),
        (0xc7, 0xc3, 0x37),
        (0xe7, 0xe3, 0x57),
        (0x7f, 0xbf, 0xff),
        (0xab, 0xe7, 0xff),
        (0xd7, 0xff, 0xff),
        (0x67, 0x00, 0x00),
        (0x8b, 0x00, 0x00),
        (0xb3, 0x00, 0x00),
        (0xd7, 0x00, 0x00),
        (0xff, 0x00, 0x00),
        (0xff, 0xf3, 0x93),
        (0xff, 0xf7, 0xc7),
        (0xff, 0xff, 0xff),
        (0x9f, 0x5b, 0x53),
    ]

    struct Header {
        let ident: Int32 = 0
        let version: Int32 = 0
        let scale: (sx: Float, sy: Float, sz: Float) = (0, 0, 0)
        let translate: (x: Float, y: Float, z: Float) = (0, 0, 0)
        let boundingRadius: Float = 0
        let eyePostion: (x: Float, y: Float, z: Float) = (0, 0, 0)

        let texturesCount: Int32 = 0
        let textureWidth: Int32 = 0
        let textureHeight: Int32 = 0

        let verticesCount: Int32 = 0
        let trianglesCount: Int32 = 0
        let framesCount: Int32 = 0

        let syncType: Int32 = 0
        let flags: Int32 = 0
        let size: Float = 0
    }

    struct MdlVertex {
        let vertex: (x: UInt8, y: UInt8, z: UInt8) = (0, 0, 0)
        let normalIndex: UInt8 = 0
    }

    struct MdlFrame {
        var isGroup: Int32 = 0
        var boundingBoxMin = MdlVertex()
        var boundingBoxMax = MdlVertex()
        let name = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        let vertices: UnsafeMutablePointer<MdlVertex>
    }

    struct MdlCoord {
        let isOnSeam: Int32 = 0
        let coord: (u: Int32, v: Int32) = (0, 0)
    }

    struct MdlTriangle {
        let isFrontFace: Int32 = 0
        let vertexIndices: (v0: Int32, v1: Int32, v2: Int32) = (0, 0, 0)
    }

    convenience init(program: ShaderProgram, mdlFilePathUrl url: URL) throws {
        var expectedIdent: UInt32 = 0
        expectedIdent += ("I".unicodeScalars.first?.value ?? 0)
        expectedIdent += ("D".unicodeScalars.first?.value ?? 0) << 8
        expectedIdent += ("P".unicodeScalars.first?.value ?? 0) << 16
        expectedIdent += ("O".unicodeScalars.first?.value ?? 0) << 24

        var vertices = [Vertex]()
        //var header = UnsafeMutablePointer<Header>.allocate(capacity: 1)
        var header = Header()
        guard var data = NSData(contentsOf: url) else { throw AppError(description: "Error reading MDL data") }
        let range = data.startIndex..<data.index(data.startIndex, offsetBy: MemoryLayout<Header>.size)
        withUnsafeMutableBytes(of: &header) { pointer in
            data.copyBytes(to: pointer, from: range)
        }

        guard header.ident == expectedIdent && header.version == Self.version else { throw AppError(description: "Not a valid MDL file") }

        var pointer = data.bytes

        // Textures
        var texture: Texture!
        pointer = pointer.advanced(by: MemoryLayout<Header>.size)
        for i in 0..<header.texturesCount {
            let isGroup = pointer.load(as: Int32.self)
            pointer = pointer.advanced(by: MemoryLayout<Int32>.size)
            if isGroup != 0 {
                throw AppError(description: "Not yet implemented")
            } else {
                let imageData = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(header.textureWidth * header.textureHeight) * 3)
                //imageData.initialize(from: pointer.assumingMemoryBound(to: UInt8.self), count: Int(header.textureWidth * header.textureHeight))
                //let texData = Data(bytes: imageData, count: MemoryLayout<UInt8>.size * 3 * Int(header.textureWidth) * Int(header.textureHeight))

                for j in 0..<(Int(header.textureWidth) * Int(header.textureHeight)) {
                    let paletteIndex = pointer.advanced(by: MemoryLayout<UInt8>.size * j).assumingMemoryBound(to: UInt8.self).pointee
                    imageData.advanced(by: MemoryLayout<UInt8>.size * j * 3 + 0).pointee = UInt8(Self.palette[Int(paletteIndex)].0)
                    imageData.advanced(by: MemoryLayout<UInt8>.size * j * 3 + 1).pointee = UInt8(Self.palette[Int(paletteIndex)].1)
                    imageData.advanced(by: MemoryLayout<UInt8>.size * j * 3 + 2).pointee = UInt8(Self.palette[Int(paletteIndex)].2)
                }

                let texData = Data(bytes: imageData, count: MemoryLayout<UInt8>.size * 3 * Int(header.textureWidth) * Int(header.textureHeight))
                //let im1 = NSBitmapImageRep(data: texData)
                //let im2 = NSImage(data: texData)
                //let bitmap = NSBitmapImageRep(data: data)
                //let im = NSImage(data: data)

                texture = Texture(rgbData: texData, width: Int(header.textureWidth), height: Int(header.textureHeight))
                pointer = pointer.advanced(by: MemoryLayout<UInt8>.size * Int(header.textureWidth) * Int(header.textureHeight))
            }
        }

        // Coordinates
        var coordinates = UnsafeMutablePointer<MdlCoord>.allocate(capacity: Int(header.verticesCount))
        coordinates.initialize(from: pointer.assumingMemoryBound(to: MdlCoord.self), count: Int(header.verticesCount))
        pointer = pointer.advanced(by: MemoryLayout<MdlCoord>.size * Int(header.verticesCount))

        // Triangles
        var triangles = UnsafeMutablePointer<MdlTriangle>.allocate(capacity: Int(header.trianglesCount))
        triangles.initialize(from: pointer.assumingMemoryBound(to: MdlTriangle.self), count: Int(header.trianglesCount))
        pointer = pointer.advanced(by: MemoryLayout<MdlTriangle>.size * Int(header.trianglesCount))

        // Model frames
        for i in 0..<1 {//header.framesCount {
            let isGroup = pointer.load(as: Int32.self)
            if isGroup != 0 {
                throw AppError(description: "Not yet implemented")
            } else {
                var frame = MdlFrame(vertices: UnsafeMutablePointer.allocate(capacity: Int(header.verticesCount)))
                frame.isGroup = pointer.load(as: Int32.self)
                pointer = pointer.advanced(by: MemoryLayout<Int32>.size)
                frame.boundingBoxMin = pointer.load(as: MdlVertex.self)
                pointer = pointer.advanced(by: MemoryLayout<MdlVertex>.size)
                frame.boundingBoxMax = pointer.load(as: MdlVertex.self)
                pointer = pointer.advanced(by: MemoryLayout<MdlVertex>.size)
                frame.name.initialize(from: pointer.assumingMemoryBound(to: UInt8.self), count: 16)
                pointer = pointer.advanced(by: MemoryLayout<UInt8>.size * 16)
                frame.vertices.initialize(from: pointer.assumingMemoryBound(to: MdlVertex.self), count: Int(header.verticesCount))

                for i in 0..<header.trianglesCount {
                    let triangle = triangles.advanced(by: Int(i)).pointee
                    // V0
                    let mdlVertex0 = frame.vertices.advanced(by: Int(triangle.vertexIndices.v0)).pointee
                    let mdlCoord0 = coordinates.advanced(by: Int(triangle.vertexIndices.v0)).pointee
                    let uOff0: Float = (triangle.isFrontFace == 0 && mdlCoord0.isOnSeam != 0) ? Float(header.textureWidth) / 2 : 0
                    let vertex0 = Vertex(
                        position: (
                            header.scale.sx * Float(mdlVertex0.vertex.x) + header.translate.x,
                            header.scale.sy * Float(mdlVertex0.vertex.y) + header.translate.y,
                            header.scale.sz * Float(mdlVertex0.vertex.z) + header.translate.z
                        ),
                        normal: (
                            Float(Self.normals[Int(mdlVertex0.normalIndex)].0),
                            Float(Self.normals[Int(mdlVertex0.normalIndex)].1),
                            Float(Self.normals[Int(mdlVertex0.normalIndex)].2)
                        ),
                        material: Material(color: (1, 1, 1), coords: ((Float(mdlCoord0.coord.u) + uOff0 + 0.5) / Float(header.textureWidth), (Float(mdlCoord0.coord.v) + 0.5) / Float(header.textureHeight)), ambient: 0.5, diffuse: 1, specular: 32)
                    )
                    vertices.append(vertex0)

                    // V1
                    let mdlVertex1 = frame.vertices.advanced(by: Int(triangle.vertexIndices.v1)).pointee
                    let mdlCoord1 = coordinates.advanced(by: Int(triangle.vertexIndices.v1)).pointee
                    let uOff1: Float = (triangle.isFrontFace == 0 && mdlCoord1.isOnSeam != 0) ? Float(header.textureWidth) / 2 : 0
                    let vertex1 = Vertex(
                        position: (
                            header.scale.sx * Float(mdlVertex1.vertex.x) + header.translate.x,
                            header.scale.sy * Float(mdlVertex1.vertex.y) + header.translate.y,
                            header.scale.sz * Float(mdlVertex1.vertex.z) + header.translate.z
                        ),
                        normal: (
                            Float(Self.normals[Int(mdlVertex1.normalIndex)].0),
                            Float(Self.normals[Int(mdlVertex1.normalIndex)].1),
                            Float(Self.normals[Int(mdlVertex1.normalIndex)].2)
                        ),
                        material: Material(color: (1, 1, 1), coords: ((Float(mdlCoord1.coord.u)  + uOff1 + 0.5) / Float(header.textureWidth), (Float(mdlCoord1.coord.v) + 0.5) / Float(header.textureHeight)), ambient: 0.5, diffuse: 1, specular: 32)
                    )
                    vertices.append(vertex1)

                    // V2
                    let mdlVertex2 = frame.vertices.advanced(by: Int(triangle.vertexIndices.v2)).pointee
                    let mdlCoord2 = coordinates.advanced(by: Int(triangle.vertexIndices.v2)).pointee
                    let uOff2: Float = (triangle.isFrontFace == 0 && mdlCoord2.isOnSeam != 0) ? Float(header.textureWidth) / 2 : 0
                    let vertex2 = Vertex(
                        position: (
                            header.scale.sx * Float(mdlVertex2.vertex.x) + header.translate.x,
                            header.scale.sy * Float(mdlVertex2.vertex.y) + header.translate.y,
                            header.scale.sz * Float(mdlVertex2.vertex.z) + header.translate.z
                        ),
                        normal: (
                            Float(Self.normals[Int(mdlVertex2.normalIndex)].0),
                            Float(Self.normals[Int(mdlVertex2.normalIndex)].1),
                            Float(Self.normals[Int(mdlVertex2.normalIndex)].2)
                        ),
                        material: Material(color: (1, 1, 1), coords: ((Float(mdlCoord2.coord.u) + uOff2 + 0.5) / Float(header.textureWidth), (Float(mdlCoord2.coord.v) + 0.5) / Float(header.textureHeight)), ambient: 0.5, diffuse: 1, specular: 32)
                    )
                    vertices.append(vertex2)
                }
            }
        }

        try self.init(program: program, vertices: vertices, texture: texture)
    }
}
