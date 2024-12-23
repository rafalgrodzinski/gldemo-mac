//
//  CastExtensions.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation
import OpenGL.GL

extension Int32 {
    var glBool: GLboolean {
        GLboolean(self)
    }

    var glEnum: GLenum {
        GLenum(self)
    }
}
