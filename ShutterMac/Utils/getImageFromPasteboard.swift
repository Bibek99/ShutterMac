//
//  getImageFromPasteboard.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 20/03/2025.
//

import Foundation
import SwiftUI

func getImageFromPasteboard(type: ScreenShotTypes) -> URL? {
    guard NSPasteboard.general.canReadItem(withDataConformingToTypes: NSImage.imageTypes),
          let image = NSImage(pasteboard: NSPasteboard.general),
          let tiffData = image.tiffRepresentation,
          let bitmapImageRep = NSBitmapImageRep(data: tiffData),
          let pngData = bitmapImageRep.representation(using: .png, properties: [:]) else {
        return nil
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd_HH:mm:ss"
    let fileName = "screenshot_\(type.description)_at_\(dateFormatter.string(from: Date())).png"
    let destinationFolderURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Pictures/ShutterMac")
    
    do {
        try FileManager.default.createDirectory(
                at: destinationFolderURL,
                withIntermediateDirectories: true,
                attributes: nil
            )
        try pngData.write(
                to: destinationFolderURL
                    .appendingPathComponent(fileName),
                options: .atomic
            )
        print("Image saved successfully at \(destinationFolderURL.path) \(fileName)")
        return destinationFolderURL
            .appendingPathComponent(fileName)
    } catch {
        print("Error saving image: \(error)")
        return nil
    }
}
