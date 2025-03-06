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
}

struct MenuBarView: View {
    @State private var image: NSImage? = nil
    
    var body: some View {
        VStack {
            if let image = image {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            HStack {
                Button {
                    takeScreenShot(type: .area)
                } label: { Image(systemName: "rectangle.dashed") }
                Button {
                    takeScreenShot(type: .window)
                } label: { Image(systemName: "macwindow") }
                Button {
                    takeScreenShot(type: .full)
                } label: { Image(systemName: "desktopcomputer") }
            }
        }
        .padding()
    }
    
    private func takeScreenShot(type: ScreenShotTypes) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
        task.arguments = type.processArguments
        
        do {
            try task.run()
            task.waitUntilExit()
            getImageFromPasteboard()
        } catch {
            print(
                "Could not capture screen. Error: \(error.localizedDescription)"
            )
        }
        
        guard NSPasteboard.general
            .canReadItem(withDataConformingToTypes: NSImage.imageTypes) else { return }
        
        guard let image = NSImage(pasteboard: NSPasteboard.general) else { return }
        self.image = image
    }
    
    private func getImageFromPasteboard() {
        guard NSPasteboard.general
            .canReadItem(withDataConformingToTypes: NSImage.imageTypes) else { return }
        guard let image = NSImage(pasteboard: NSPasteboard.general) else { return }
        self.image = image
    }
}
