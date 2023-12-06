//
//  SampleFramework.swift
//  SampleFramework
//
//  Created by Admin on 20/11/23.
//

import Foundation

public class SampleAccelloriOSFramework {
    public static let shared = SampleAccelloriOSFramework()

    public func sendObjectToMainProject(selectedObject: RaceTracLocationInfo) {
        
        let myObject = RaceTracLocationInfo(locationId: selectedObject.locationId, city: selectedObject.city, address: selectedObject.address, storeId: selectedObject.storeId, lat: selectedObject.lat, log: selectedObject.log, distance: selectedObject.distance, regularPrice: selectedObject.regularPrice, dieselPrice: selectedObject.dieselPrice, amenities: selectedObject.amenities, fuelOptions: selectedObject.fuelOptions, hours: selectedObject.hours)
        
        NotificationCenter.default.post(name: Notification.Name("SampleAccelloriOSFrameworkDidSelectRow"), object: myObject)
    }
}
