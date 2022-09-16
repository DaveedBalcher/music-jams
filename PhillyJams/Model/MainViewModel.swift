//
//  VenuesViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/8/22.
//

import SwiftUI
import MapKit
import MusicVenues


class MainViewModel: ObservableObject {
    
    @Published var mapRegion: MKCoordinateRegion
    
    private var venues: [VenueItem] = []
    @Published var filteredVenues: [VenueItem] = []
    @Published var selectedVenue: VenueItem?
    
    private var mapRegions: [MapRegionItem] = []
    @Published var filteredMapRegions: [MapRegionItem] = []
    @Published var selectedMapRegion: MapRegionItem
    
    @Published var filterOptions: [String: [String]] = [:]
    @Published var filtersSelected: [String: String?] = [:] {
        didSet {
            filterVenues()
        }
    }
    
    let venueLoader: VenueLoader!
    
    init(initialMapRegion: MapRegionItem, venueLoader: VenueLoader) {
        self.venueLoader = venueLoader
        
        _mapRegion = Published(initialValue: initialMapRegion.region)
        _selectedMapRegion = Published(initialValue: initialMapRegion)
        self.filteredMapRegions = [selectedMapRegion]
    }
    
    func retrieveVenuesData() {
        venueLoader.load { [weak self] venueItems in
            self?.venues = venueItems
            self?.filteredVenues = venueItems
            self?.mapRegions = venueItems.neighborhoods.maptoMapRegionItems()
            self?.filterOptions = self?.venueLoader.retrieveFilters(for: venueItems) ?? [:]
            
        }
    }
    
    func setMapRegion(name: String? = nil) {
        if let neighborhood = filteredMapRegions.first(where: { $0.name == name }) ?? filteredMapRegions.first {
            selectedMapRegion = neighborhood
        }
        setInitialVenue()
        
        mapRegion = selectedMapRegion.region
    }
    
    func setInitialVenue() {
        selectedVenue = filteredVenues.first { selectedMapRegion.name == $0.neighborhood?.name}
    }
    
    func filterVenues() {
        filteredVenues = FilterProcesser.filter(venues, with: filtersSelected)
        filteredMapRegions = filteredVenues.neighborhoods.maptoMapRegionItems()
        
        if !(filteredMapRegions.contains { $0.name == selectedVenue?.neighborhood?.name }) {
            setMapRegion()
        }
    }
    
    func checkVenueAvailable() -> Bool {
        !venues.isEmpty && filteredVenues.isEmpty
    }
}

extension Coordinates {
    
    var mapCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
