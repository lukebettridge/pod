//
//  HealthKit.swift
//  Pod
//
//  Created by Luke Bettridge on 06/01/2021.
//

import HealthKit

class HealthKit {
    
    enum HealthKitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    static func authorize(completion: @escaping (Bool, Error?) -> Void) {
        if !HKHealthStore.isHealthDataAvailable() {
            return completion(false, HealthKitSetupError.notAvailableOnDevice)
        }
        
        if let caffeineType = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine),
           let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater) {
            HKHealthStore().requestAuthorization(
                toShare: [caffeineType, waterType],
                read: [],
                completion: completion
            )
        } else {
            completion(false, HealthKitSetupError.dataTypeNotAvailable)
        }
    }
    
    static func authorizationStatus() -> HKAuthorizationStatus? {
        if HKHealthStore.isHealthDataAvailable() {
            if let caffeineType = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine),
               let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater) {
                let status = [
                    HKHealthStore().authorizationStatus(for: caffeineType),
                    HKHealthStore().authorizationStatus(for: waterType)
                ]
                
                if status.contains(.sharingDenied) { return .sharingDenied }
                if status.contains(.notDetermined) { return .notDetermined }
                return .sharingAuthorized
            }
        }
        return nil
    }
    
    static func write(
        dietaryCaffeine: Double,
        dietaryWater: Double,
        date: Date,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        if let caffeineType = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine),
           let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater) {
            
            // Caffeine
            let caffeineUnit = HKUnit.gramUnit(with: .milli)
            let caffeineQuantity = HKQuantity(unit: caffeineUnit, doubleValue: dietaryCaffeine)
            let caffeineSample = HKQuantitySample(type: caffeineType, quantity: caffeineQuantity, start: date, end: date)
            
            // Water
            let waterUnit = HKUnit.literUnit(with: .milli)
            let waterQuantity = HKQuantity(unit: waterUnit, doubleValue: dietaryWater)
            let waterSample = HKQuantitySample(type: waterType, quantity: waterQuantity, start: date, end: date)
            
            HKHealthStore().save([
                caffeineSample,
                waterSample
            ], withCompletion: completion)
            return
        }
        completion(false, HKError(.errorHealthDataUnavailable))
    }
}
