//
//  ScreenShotTypes.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 20/03/2025.
//

import Foundation

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
