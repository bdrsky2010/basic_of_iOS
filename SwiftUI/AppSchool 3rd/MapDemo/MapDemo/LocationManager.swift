//
//  LocationManager.swift
//  MapDemo
//
//  Created by Minjae Kim on 1/2/24.
//

import Foundation
import CoreLocation

class LocationManager {
	let locationManager = CLLocationManager()
	var currentLocation: CLLocation?
	
	func requestLocationPermission() {
		locationManager.requestWhenInUseAuthorization()
	}
	
	func getCurrentLocation() {
		locationManager.startUpdatingLocation()
		currentLocation = locationManager.location
	}
}
