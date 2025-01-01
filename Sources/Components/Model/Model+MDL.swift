//
//  Model+MDL.swift
//  glDemo
//
//  Created by Rafał on 2024/12/29.
//

import Foundation
import OpenGL.GL
import Cocoa
import GLKit

extension Model {
    private static let ident = 1330660425 // 'I' << 0 + 'D' << 8 + 'P' << 16 + 'O' << 24
    private static let version = 6
    private static let frameDuration: TimeInterval = 0.1
    private static let normals: [(x: Float32, y: Float32, z: Float32)] = [
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
    private static let colorsPalette: [(r: UInt8, g: UInt8, b: UInt8)] = [
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

    struct MdlHeader {
        let ident: Int32
        let version: Int32
        let scale: (sx: Float32, sy: Float32, sz: Float32)
        let translate: (x: Float32, y: Float32, z: Float32)
        let boundingRadius: Float32
        let eyePostion: (x: Float32, y: Float32, z: Float32)

        let texturesCount: Int32
        let textureWidth: Int32
        let textureHeight: Int32

        let verticesCount: Int32
        let trianglesCount: Int32
        let framesCount: Int32

        let syncType: Int32
        let flags: Int32
        let size: Float32
    }

    struct MdlCoord {
        let isOnSeam: Int32
        let coord: (u: Int32, v: Int32)
    }

    struct MdlTriangle {
        let isFrontFace: Int32
        let vertexIndices: (v0: Int32, v1: Int32, v2: Int32)
    }

    struct MdlVertex {
        let vertex: (x: UInt8, y: UInt8, z: UInt8)
        let normalIndex: UInt8
    }

    convenience init(program: ShaderProgram, mdlFilePathUrl url: URL) throws {
        var modelFrames = [[Vertex]]()

        guard var mdlData = NSData(contentsOf: url) else { throw AppError(description: "Error reading MDL data") }
        var mdlDataPointer = mdlData.bytes

        // Header
        var header: MdlHeader!
        header = mdlDataPointer.load(as: MdlHeader.self)
        guard header.ident == Self.ident && header.version == Self.version else { throw AppError(description: "Not a valid MDL file") }
        mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<MdlHeader>.size)

        // Textures
        var texture: Texture!
        guard header.texturesCount == 1 else { throw AppError(description: "Multiple textures not implemented") }
        let isTexturesGroup = mdlDataPointer.load(as: Int32.self)
        mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<Int32>.size)
        if isTexturesGroup != 0 {
            throw AppError(description: "Texture groups not implemented")
        } else {
            let pixelsCount = header.textureWidth.int * header.textureHeight.int
            let textureDataPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: pixelsCount * 3)

            for i in 0..<pixelsCount {
                let colorsPaletteIndex = mdlDataPointer.advanced(by: MemoryLayout<UInt8>.size * i).assumingMemoryBound(to: UInt8.self).pointee
                textureDataPointer.advanced(by: MemoryLayout<UInt8>.size * i * 3 + 0).pointee = Self.colorsPalette[colorsPaletteIndex.int].r
                textureDataPointer.advanced(by: MemoryLayout<UInt8>.size * i * 3 + 1).pointee = Self.colorsPalette[colorsPaletteIndex.int].g
                textureDataPointer.advanced(by: MemoryLayout<UInt8>.size * i * 3 + 2).pointee = Self.colorsPalette[colorsPaletteIndex.int].b
            }

            let textureData = Data(bytes: textureDataPointer, count: MemoryLayout<UInt8>.size * pixelsCount * 3)
            texture = Texture(rgbData: textureData, width: header.textureWidth.int, height: header.textureHeight.int)
            mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<UInt8>.size * header.textureWidth.int * header.textureHeight.int)
        }

        // Coordinates
        var coordinatesPointer = UnsafeMutablePointer<MdlCoord>.allocate(capacity: header.verticesCount.int)
        coordinatesPointer.initialize(from: mdlDataPointer.assumingMemoryBound(to: MdlCoord.self), count: header.verticesCount.int)
        mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<MdlCoord>.size * header.verticesCount.int)

        // Triangles
        var trianglesPointer = UnsafeMutablePointer<MdlTriangle>.allocate(capacity: header.trianglesCount.int)
        trianglesPointer.initialize(from: mdlDataPointer.assumingMemoryBound(to: MdlTriangle.self), count: header.trianglesCount.int)
        mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<MdlTriangle>.size * header.trianglesCount.int)

        // Frames
        for frameIndex in 0..<header.framesCount.int {
            var modelVertices = [Vertex]()

            // Is frames group
            let isFramesGroup = mdlDataPointer.load(as: Int32.self)
            mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<Int32>.size)

            if isFramesGroup != 0 {
                throw AppError(description: "Frames group not yet implemented")
            } else {
                // Bounding box min
                mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<MdlVertex>.size)

                // Bounding box max
                mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<MdlVertex>.size)

                // Name
                mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<UInt8>.size * 16)

                // Vertices
                let verticesPointer = UnsafeMutablePointer<MdlVertex>.allocate(capacity: header.verticesCount.int)
                verticesPointer.initialize(from: mdlDataPointer.assumingMemoryBound(to: MdlVertex.self), count: header.verticesCount.int)

                for triangleIndex in 0..<header.trianglesCount.int {
                    let triangle = trianglesPointer.advanced(by: triangleIndex).pointee
                    let mdlVertexIndices = [triangle.vertexIndices.v0.int, triangle.vertexIndices.v1.int, triangle.vertexIndices.v2.int]

                    for mdlVertexIndex in mdlVertexIndices {
                        let vertex = verticesPointer.advanced(by: mdlVertexIndex).pointee
                        var coord = coordinatesPointer.advanced(by: mdlVertexIndex).pointee
                        if !triangle.isFrontFace.bool && coord.isOnSeam.bool {
                            coord = MdlCoord(isOnSeam: coord.isOnSeam, coord: (coord.coord.u + header.textureWidth / 2, coord.coord.v))
                        }

                        // Fixing orientation (since X is up and -Y is forward)
                        var matrix = GLKMatrix4MakeXRotation(-Float.pi/2)
                        matrix = GLKMatrix4RotateZ(matrix, -Float.pi/2)
                        var position = GLKVector3(v: (
                            header.scale.sx * vertex.vertex.x.float + header.translate.x,
                            header.scale.sy * vertex.vertex.y.float + header.translate.y,
                            header.scale.sz * vertex.vertex.z.float + header.translate.z
                        ))
                        position = GLKMatrix4MultiplyVector3(matrix, position)

                        let modelVertex = Vertex(
                            position: (position.x, position.y, position.z),
                            normal: (
                                Self.normals[vertex.normalIndex.int].x.float,
                                Self.normals[vertex.normalIndex.int].y.float,
                                Self.normals[vertex.normalIndex.int].z.float
                            ),
                            material: Material(
                                color: (1, 1, 1),
                                coords: ((coord.coord.u.float + 0.5) / header.textureWidth.float, (coord.coord.v.float + 0.5) / header.textureHeight.float),
                                ambient: 0.5,
                                diffuse: 1,
                                specular: 16
                            )
                        )
                        modelVertices.append(modelVertex)
                    }
                }
                mdlDataPointer = mdlDataPointer.advanced(by: MemoryLayout<MdlVertex>.size * header.verticesCount.int)
            }

            modelFrames.append(modelVertices)
        }

        try self.init(program: program, frames: modelFrames, frameDuration: Self.frameDuration, texture: texture)
    }
}
