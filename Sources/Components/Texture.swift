//
//  Texture.swift
//  glDemo
//
//  Created by Rafał on 2024/12/30.
//

import Cocoa

final class Texture {
    let dataPointer: UnsafePointer<UInt8>
    let width: Int
    let height: Int
    let pixelFormat: GLenum

    static let whitePixel = Texture(rgbData: Data(repeating: 255, count: 3), width: 1, height: 1)

    init(rgbData: Data, width: Int, height: Int) {
        var data = NSData(data: rgbData)
        dataPointer = data.bytes.assumingMemoryBound(to: UInt8.self)
        self.width = width
        self.height = height
        pixelFormat = GLenum(GL_RGB)
    }

    init(imageName: String) throws {
        var image: NSImage? = NSImage(named: imageName)
        if image == nil {
            guard let url = Bundle.main.url(forResource: imageName, withExtension: nil) else {
                throw AppError(description: "No image \(imageName)")
            }
            image = NSImage(byReferencing: url)
        }

        guard let tiffImage = image?.tiffRepresentation else { throw AppError(description: "Couldn't get tiffImage for \(imageName)") }
        guard let bitmap = NSBitmapImageRep(data: tiffImage) else { throw AppError(description: "Couldn't get bitmap for \(imageName)") }
        guard let pointer = bitmap.bitmapData else { throw AppError(description: "Couldn't get data pointer") }
        dataPointer = UnsafePointer(pointer)
        width = bitmap.pixelsWide
        height = bitmap.pixelsHigh
        pixelFormat = GLenum(GL_RGBA)
    }
}
