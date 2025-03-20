//
//  KeyboardShortcuts.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 20/03/2025.
//

import Foundation
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let screenshotCaptureFull = Self("screenshotCaptureFull", default: .init(.three, modifiers: [.option, .command]))
    
    static let screenshotCaptureArea = Self("screenshotCaptureArea", default: .init(.four, modifiers: [.option, .command]))
    
    static let screenshotCaptureWindow = Self("screenshotCaptureWindow", default: .init(.five, modifiers: [.option, .command]))
}
