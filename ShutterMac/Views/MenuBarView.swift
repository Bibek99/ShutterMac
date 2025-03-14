//
//  MenuBarView.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 06/03/2025.
//

import Foundation
import SwiftUI

enum ScreenShotTypes {
    case full
    case window
    case area
    
    var processArguments: [String] {
        switch self {
        case .full:
            ["-c"]
        case .window:
            ["-cw"]
        case .area:
            ["-cs"]
        }
    }
    
    var description: String {
        switch self {
        case .full:
            "fullScreen"
        case .window:
            "window"
        case .area:
            "area"
        }
    }
}

struct MenuBarView: View {
    @State private var imageURL: URL? = nil
    
    var body: some View {
        VStack {
            if let imageURL = imageURL, let image = NSImage(contentsOfFile: imageURL.path) {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .onDrag {
                        let provider = NSItemProvider(contentsOf: imageURL)!
                        return provider
                    }
            }
            
            HStack {
                Button {
                    NSApplication.shared.hide(nil)
                    takeScreenShot(type: .area)
                    NSApplication.shared.unhide(nil)
                } label: { Image(systemName: "rectangle.dashed") }
                Button {
                    NSApplication.shared.hide(nil)
                    takeScreenShot(type: .window)
                    NSApplication.shared.unhide(nil)
                } label: { Image(systemName: "macwindow") }
                Button {
                    takeScreenShot(type: .full)
                } label: { Image(systemName: "desktopcomputer") }
            }
            .padding(.horizontal)
            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Text("Quit")
            }
            .padding(.top)
        }
        .padding(.vertical)
    }
    
    private func takeScreenShot(type: ScreenShotTypes) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
        task.arguments = type.processArguments
        
        do {
            try task.run()
            task.waitUntilExit()
            getImageFromPasteboard(type: type)
        } catch {
            print(
                "Could not capture screen. Error: \(error.localizedDescription)"
            )
        }
    }
    
    private func getImageFromPasteboard(type: ScreenShotTypes) {
        guard NSPasteboard.general
            .canReadItem(withDataConformingToTypes: NSImage.imageTypes) else { return }
        guard let image = NSImage(pasteboard: NSPasteboard.general) else { return }
        guard let tiffData = image.tiffRepresentation else { return }
        guard let bitmapImageRep = NSBitmapImageRep(data: tiffData) else { return }
        guard let pngData = bitmapImageRep.representation(using: .png, properties: [:]) else { return }
        
        let fileName = "screenshot_\(type.description)_at_\(Date()).png"
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
            self.imageURL = destinationFolderURL
                .appendingPathComponent(fileName)
        } catch {
            print("Error saving image: \(error)")
        }
    }
}
