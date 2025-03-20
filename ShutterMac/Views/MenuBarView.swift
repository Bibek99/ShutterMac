//
//  MenuBarView.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 06/03/2025.
//

import Foundation
import SwiftUI

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
                    .padding(.horizontal)
            }
            
            HStack {
                Button {
                    NSApplication.shared.hide(nil)
                    takeScreenShot(type: .area) { imageURL in
                        updateimageURL(imageURL)
                    }
                    NSApplication.shared.unhide(nil)
                } label: { Image(systemName: "rectangle.dashed") }
                Button {
                    NSApplication.shared.hide(nil)
                    takeScreenShot(type: .window) { imageURL in
                        updateimageURL(imageURL)
                    }
                    NSApplication.shared.unhide(nil)
                } label: { Image(systemName: "macwindow") }
                Button {
                    takeScreenShot(type: .full) { imageURL in
                        updateimageURL(imageURL)
                    }
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
    
    private func updateimageURL(_ url: URL?) {
        imageURL = url
    }
}
