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
    
    @Published var venues: [VenueItem] = []
    @Published var selectedVenue: VenueItem?
    
    @Published var mapRegions: [MapRegionItem] = []
    @Published var selectedMapRegion: MapRegionItem {
        didSet {
            setInitialVenue()
            mapRegion = selectedMapRegion.region
        }
    }
    
    @Published var genreOptions: [GenreType] = []
    @Published var selectedGenre = GenreType.defaultValue {
        didSet {
            filterVenues()
        }
    }
    
    @Published var vibeOptions: [VibeType] = VibeType.allCases
    @Published var selectedVibe = VibeType.defaultValue {
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
        venueLoader.retrieveFiltered { [weak self] venueItems, neighborhoodItems, genreOptions, vibeOptions in
            self?.venues = venueItems
            self?.mapRegions = neighborhoodItems.maptoMapRegionItems()
            self?.genreOptions = genreOptions
            self?.vibeOptions = vibeOptions
        }
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
        let genreParameter = FilterParameter(type: .genres, values: [selectedGenre.rawValue])
        let vibeParameter = FilterParameter(type: .vibes, values: [selectedVibe.rawValue])
        venueLoader.retrieveFiltered(filters: [genreParameter, vibeParameter]) { [weak self] venueItems, neighborhoodItems, genreOptions, vibeOptions in
            self?.venues = venueItems
            self?.mapRegions = neighborhoodItems.maptoMapRegionItems()
            self?.setNeighborhood(name: self?.selectedMapRegion.name)
        }
    }
}

extension Coordinates {
    
    var mapCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
