//
//  StringExtensiosn.swift
//  glDemo
//
//  Created by Rafal on 24/12/2024.
//

import Foundation

extension String {
    var int: Int {
        NSString(string: self).integerValue
    }

    var float: Float {
        NSString(string: self).floatValue
    }
}
