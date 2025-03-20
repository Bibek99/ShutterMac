//
//  takeScreenshot.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 20/03/2025.
//

import Foundation

func takeScreenShot(
    type: ScreenShotTypes,
    completion: @escaping (URL?) -> Void
) {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
    task.arguments = type.processArguments
    
    do {
        try task.run()
        task.waitUntilExit()
        let imageURL = getImageFromPasteboard(type: type)
        completion(imageURL)
    } catch {
        print(
            "Could not capture screen. Error: \(error.localizedDescription)"
        )
    }
}
