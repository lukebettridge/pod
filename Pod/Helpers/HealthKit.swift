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
        guard HKHealthStore.isHealthDataAvailable() else {
            return completion(false, HealthKitSetupError.notAvailableOnDevice)
        }
     
        guard let dietaryCaffeine = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine) else {
            return completion(false, HealthKitSetupError.dataTypeNotAvailable)
        }
            
        let healthKitTypesToWrite: Set<HKSampleType> = [dietaryCaffeine]
            
        HKHealthStore().requestAuthorization(
            toShare: healthKitTypesToWrite,
            read: [],
            completion: completion
        )
    }
    
    static func authorizationStatus() -> HKAuthorizationStatus? {
        if HKHealthStore.isHealthDataAvailable() {
            if let dietaryCaffeine = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine) {
                return HKHealthStore().authorizationStatus(for: dietaryCaffeine)
            }
        }
        return nil
    }
    
    static func writeCaffeine(
        dietaryCaffeine: Double,
        date: Date,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        if let type = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine) {
            let unit = HKUnit.gramUnit(with: .milli)
            let quantity = HKQuantity(unit: unit, doubleValue: dietaryCaffeine)
            let sample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)
            HKHealthStore().save(sample, withCompletion: completion)
            return
        }
        completion(false, HKError(.errorHealthDataUnavailable))
    }
}
