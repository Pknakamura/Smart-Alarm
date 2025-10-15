//
//  HealthKitStore.swift
//  Smart Alarm
//
//  Created by Phillip Nakamura on 9/24/25.
//

import Foundation
import HealthKit
import Combine

@Observable
class ModelData: NSObject, ObservableObject {
//    let status = HKHealthStore.authorizationStatus(for: HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!)
//
    @Published var user_prefrences = Preferences()
    @Published var alarms: [Alarm] = []
    
    struct Alarm: Codable, Identifiable {
        var id: UUID = UUID()
        var name: String
        var targetTime: Date = Date()
        var isEnabled: Bool = true
        var Repeating: Bool = false
        var repeatSchedule: Schedule = .simple(0)
       
        var smart: Bool
        var allowedRange: TimeInterval
        
        struct Schedule: OptionSet, Codable {
            let rawValue: Int
            
            static let is_simple = Schedule(rawValue: 1 << 0)
            static let mon = Schedule(rawValue: 1 << 1)
            static let tue = Schedule(rawValue: 1 << 2)
            static let wed = Schedule(rawValue: 1 << 3)
            static let thu = Schedule(rawValue: 1 << 4)
            static let fri = Schedule(rawValue: 1 << 5)
            static let sat = Schedule(rawValue: 1 << 6)
            static let sun = Schedule(rawValue: 1 << 7)
            
            static func simple(_ intervalDays: Int) -> Schedule {
                Schedule(rawValue: (intervalDays << 1) | 1)
            }
            
            func getInterval() -> Int {
                rawValue >> 1
            }
        }
    }
    
    
    
    struct Preferences: Codable {
        var getLouderDuration: TimeInterval = (15.0 * 60.0)
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void){
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }
        
        let healthStore = HKHealthStore()
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        healthStore.requestAuthorization(toShare: [], read: typesToRead) { (success, error) in
            if !success, let error = error {
                    print("Authorization failed: \(error.localizedDescription)")
            }
            completion(success)
        }
    }
}

