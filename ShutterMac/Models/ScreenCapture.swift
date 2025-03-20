//
//  ScreenCapture.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 20/03/2025.
//

import Foundation
import KeyboardShortcuts

class ScreenCapture: ObservableObject {
    @Published var imageURL: URL? = nil

    init() {
        KeyboardShortcuts.onKeyUp(for: .screenshotCaptureFull) { [self] in
            captureFull()
        }
        
        KeyboardShortcuts.onKeyUp(for: .screenshotCaptureArea) { [self] in
            captureArea()
        }
        
        KeyboardShortcuts.onKeyUp(for: .screenshotCaptureWindow) { [self] in
            captureWindow()
        }
    }
    
    func captureFull() {
        takeScreenShot(type: .full, completion: updateImageURL)
    }
    
    func captureArea() {
        takeScreenShot(type: .area, completion: updateImageURL)
    }
    
    func captureWindow() {
        takeScreenShot(type: .window, completion: updateImageURL)
    }
    
    private func updateImageURL(_ url: URL?) {
        imageURL = url
    }
}
