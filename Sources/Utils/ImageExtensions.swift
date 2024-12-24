//
//  ImageExtensions.swift
//  glDemo
//
//  Created by Rafal on 24/12/2024.
//

import Cocoa

extension NSBitmapImageRep {
    static func bitmap(forImageName imageName: String) throws -> NSBitmapImageRep {
        var image: NSImage? = NSImage(named: imageName)
        if image == nil {
            guard let url = Bundle.main.url(forResource: imageName, withExtension: nil) else {
                throw AppError(description: "No image \(imageName)")
            }
            image = NSImage(byReferencing: url)
        }

        guard let tiffImage = image?.tiffRepresentation else { throw AppError(description: "Couldn't get tiffImage for \(imageName)") }
        guard let bitmap = NSBitmapImageRep(data: tiffImage) else { throw AppError(description: "Couldn't get bitmap for \(imageName)") }
        return bitmap
    }
}
