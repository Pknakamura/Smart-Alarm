//
//  Smart_AlarmApp.swift
//  Smart Alarm
//
//  Created by Phillip Nakamura on 9/24/25.
//

import SwiftUI
import SwiftData

@main
struct Smart_AlarmApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(modelData)
    }
}
