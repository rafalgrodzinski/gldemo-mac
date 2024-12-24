//
//  CollectionExtensions.swift
//  glDemo
//
//  Created by Rafal on 24/12/2024.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
