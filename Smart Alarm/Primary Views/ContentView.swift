//
//  ContentView.swift
//  Smart Alarm
//
//  Created by Phillip Nakamura on 9/24/25.
//

import SwiftUI
import SwiftData
import HealthKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
   

    var body: some View {
        
        
    }
    
    
}

#Preview {
    ContentView()
        .environment(ModelData())
}
