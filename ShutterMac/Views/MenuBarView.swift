//
//  MenuBarView.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 06/03/2025.
//

import Foundation
import SwiftUI

struct MenuBarView: View {
    @ObservedObject var screenCapture: ScreenCapture
    
    var body: some View {
        VStack {
            if let imageURL = screenCapture.imageURL, let image = NSImage(
                contentsOfFile: imageURL.path
            ) {
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
                    screenCapture.captureFull()
                } label: { Image(systemName: "desktopcomputer") }
                
                Button {
                    NSApplication.shared.hide(nil)
                    screenCapture.captureArea()
                    NSApplication.shared.unhide(nil)
                } label: { Image(systemName: "rectangle.dashed") }
                
                Button {
                    NSApplication.shared.hide(nil)
                    screenCapture.captureWindow()
                    NSApplication.shared.unhide(nil)
                } label: { Image(systemName: "macwindow") }
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
}
