//
//  ShutterMacApp.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 06/03/2025.
//

import SwiftUI
import SwiftData

@main
struct ShutterMacApp: App {
    var body: some Scene {
        MenuBarExtra("ShutterMac App", systemImage: "sparkles") {
            MenuBarView()
        }
        .menuBarExtraStyle(.window)
    }
}
