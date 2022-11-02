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
    
    static var zoomedOutMapRegion: Subregion {
        Subregion(
            name: "Philadelphia",
            mkRegion: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 39.975, longitude: -75.175),
                span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)),
            color: nil)
    }
    
    @Published var mapRegion: MKCoordinateRegion
    
    private var venues: [VenueItem] = []
    @Published var filteredVenues: [VenueItem] = []
    @Published var selectedVenue: VenueItem? {
        didSet {
            setMapRegion(name: selectedVenue?.neighborhood?.name)
        }
    }
    
    private var mapRegions: [Subregion] = []
    @Published var filteredMapRegions: [Subregion] = []
    @Published var selectedMapRegion: Subregion
    
    @Published var filterOptions: [String: [String]] = [:]
    @Published var filtersSelected: [String: String?] = [:] {
        didSet {
            filterVenues()
        }
    }
    
    var regionFiltersDescription: String {
        let strings = filtersSelected.compactMap { $0.value }
        return strings.isEmpty ? "All Events · Vibes · Genres" : strings.joined(separator: " · ")
    }
    
    var isZoomedOut: Bool {
        selectedMapRegion == Self.zoomedOutMapRegion
    }
    
    let venueLoader: VenueLoader!
    
    init(venueLoader: VenueLoader) {
        self.venueLoader = venueLoader
        
        _mapRegion = Published(initialValue: Self.zoomedOutMapRegion.mkRegion)
        _selectedMapRegion = Published(initialValue: Self.zoomedOutMapRegion)
        self.filteredMapRegions = [selectedMapRegion]
    }
    
    func retrieveVenuesData() {
        venueLoader.load { [weak self] venueItems in
            self?.venues = venueItems
            self?.filterVenues()
            self?.mapRegions = venueItems.neighborhoods.maptoSubregions()
            self?.filteredMapRegions = venueItems.neighborhoods.maptoSubregions()
            self?.filterOptions = FilterProcesser.retrieveFilters(for: venueItems)
        }
    }
    
    func setMapRegion(name: String? = nil) {
        selectedMapRegion = filteredMapRegions.first(where: { $0.name == name }) ?? Self.zoomedOutMapRegion
        mapRegion = selectedMapRegion.mkRegion
    }
    
    func setInitialVenue() {
        selectedVenue = filteredVenues.first { selectedMapRegion.name == $0.neighborhood?.name}
    }
    
    func filterVenues() {
        let venues = FilterProcesser.filter(venues, with: filtersSelected)
//        let sortedVenues = venues.sorted { $0.nextDayOfEventIndex > $1.nextDayOfEventIndex }
        filteredVenues = venues
        filteredMapRegions = filteredVenues.neighborhoods.maptoSubregions()
        
        if !(filteredMapRegions.contains { $0.name == selectedVenue?.neighborhood?.name }) {
            setMapRegion()
        }
    }
    
    func hasEvents() -> Bool {
        !venues.isEmpty && filteredVenues.isEmpty
    }
}

extension Coordinates {
    
    var mapCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
