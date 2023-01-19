//
//  MapViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/16/22.
//

import SwiftUI
import MapKit
import MusicVenues


// MapViewModel - Holds state for selected region and scope of selected region
//              - Asks user for permission to get current gps location and stores location
//              - Sets initial region closes to the user's current location
enum MapDefaults {
    static let region = Region(
        title: "Philadelphia",
        colorString: "006BB6",
        level: .two,
        latitude: 39.975,
        longitude: -75.175
    )
}

final class MapViewModel: NSObject, ObservableObject {
    @Published var places: [Place] = [] {
        didSet {
            allRegions = Set(places.map { $0.regionLevelOne }).sorted()
            
            //TODO: If selectedPlace or selected Region not included in places or regions, set to default
        }
    }
    @Published var selectedPlace: Place? {
        willSet {
            didPublish()
        }
    }
    
    var didPublish: () -> Void = {}

    @Published var selectedMKRegion: MKCoordinateRegion = MapDefaults.region.mkRegion
    @Published var selectedRegion: Region = MapDefaults.region {
        didSet {
            selectedMKRegion = selectedRegion.mkRegion
        }
    }
            
    private(set) var allRegions: [Region] = []
    
    private var locationManager: CLLocationManager?
    private var userCoordinate: CLLocationCoordinate2D?
    private var locationServicesEnabled: Bool = false
    
    var isZoomedIn: Bool {
        selectedRegion.level == .one
    }
    
    var hasEvents: Bool {
        !(places.filter { !$0.events.isEmpty }.isEmpty)
    }
    
    init(places: [Place]) {
        self.places = places
    }
    
    private func setInitialPlace() {
        guard let place = places.first else { return }
        selectedPlace = place
        selectedRegion = place.regionLevelOne
    }
    
    func zoomOutToLevelTwo() {
        selectedRegion = MapDefaults.region
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func checkIfLocationServicesIsEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager = CLLocationManager()
//            locationManager!.delegate = self
//        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls")
        case .denied:
            print("You have denied this app's location permission. Got to settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            userCoordinate = locationManager.location?.coordinate
        @unknown default:
            break
        }
    }
    
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationServicesEnabled = manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse
        checkLocationAuthorization()
    }
}
