//
//  Item.swift
//  ShutterMac
//
//  Created by Bibek Basyal on 06/03/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
