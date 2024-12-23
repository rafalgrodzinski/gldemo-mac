//
//  AppError.swift
//  glDemo
//
//  Created by Rafal on 23/12/2024.
//

import Foundation

extension Error {
    var description: String {
        if let appError = self as? AppError {
            return appError.description
        } else {
            return self.localizedDescription
        }
    }
}

struct AppError: Error {
    let description: String
}
