//
//  LocationManager.swift
//
//
//  Created by Jan Verrept on 29/09/2023.
//

import Foundation
import CoreLocation
import OSLog

/// A Swift shell around the objective-C type CLLocationManager for convenience
public class LocationManager: NSObject{
    
    private let locationManager = CLLocationManager()
    
    public var location: CLLocation?
    
    public init(withAccuracy accuracy:CLLocationAccuracy = kCLLocationAccuracyHundredMeters) {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        self.updateLocation()
    }
    
    public func updateLocation(){
                
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
    }

}

// MARK: - CLLocationManagerDelegate

extension LocationManager:CLLocationManagerDelegate{
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        locationManager.stopUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        let logger = Logger(subsystem: "be.oneclick.JVSwift", category:"LocationManager")
        logger.error("\(error.localizedDescription)")
    }
}
