//
//  VenuesViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/8/22.
//

import SwiftUI
import MapKit
import MusicVenues


class VenuesViewModel: ObservableObject {
    
    @Published var mapRegion: MKCoordinateRegion
    
    @Published var venues: [VenueItem] = []
    @Published var selectedVenue: VenueItem?
    
    @Published var mapRegions: [MapRegionItem] = []
    @Published var selectedMapRegion: MapRegionItem {
        didSet {
            setInitialVenue()
            mapRegion = selectedMapRegion.region
        }
    }
    
    @Published var genreOptions: [String] = []
    @Published var selectedGenres = Set<String>() {
        didSet {
            filterVenues()
        }
    }
    
    @Published var vibeOptions: [String] = []
    @Published var selectedVibes = Set<String>() {
        didSet {
            filterVenues()
        }
    }
    
    let venueLoader: VenueLoader!
    
    init(initialMapRegion: MapRegionItem, venueLoader: VenueLoader) {
        self.venueLoader = venueLoader
        
        _mapRegion = Published(initialValue: initialMapRegion.region)
        _selectedMapRegion = Published(initialValue: initialMapRegion)
        self.mapRegions = [selectedMapRegion]
    }
    
    func retrieveVenuesData() {
        let (venues, neighborhoods, filters) = venueLoader.retrieveFiltered()
        self.venues = venues
        self.mapRegions = neighborhoods.maptoMapRegionItems()
        self.genreOptions = filters.genreOptions
        self.vibeOptions = filters.vibeOptions
    }
    
    func setNeighborhood(name: String? = nil) {
        if let neighborhood = mapRegions.first(where: { $0.name == name }) ?? mapRegions.first {
            selectedMapRegion = neighborhood
        }
        setInitialVenue()
    }
    
    func setInitialVenue() {
        selectedVenue = venues.first { selectedMapRegion.name == $0.neighborhood?.name}
    }
    
    func filterVenues() {
        let genreParameter = FilterParameter(type: .genres, values: selectedGenres)
        let vibeParameter = FilterParameter(type: .vibes, values: selectedVibes)
        let (venueItems, neighborhoodItems, _) = venueLoader.retrieveFiltered(filters: [genreParameter, vibeParameter])
        self.venues = venueItems
        self.mapRegions = neighborhoodItems.maptoMapRegionItems()
        setNeighborhood(name: selectedMapRegion.name)
    }
}

extension Coordinates {
    
    var mapCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
