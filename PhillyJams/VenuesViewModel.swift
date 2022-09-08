//
//  VenuesViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/8/22.
//

import SwiftUI
import MapKit
import MusicVenues

enum Selected<Wrapped> {
    case all
    case one(Wrapped)
}


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
    
    @Published var genreOptions: [GenreType] = []
    @Published var selectedGenre: Selected<GenreType> = .all {
        didSet {
            filterVenues()
        }
    }
    
    @Published var vibeOptions: [VibeType] = VibeType.allCases
    @Published var selectedVibe: Selected<VibeType> = .all {
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
        let (venues, neighborhoods, genres, vibes) = venueLoader.retrieveFiltered()
        self.venues = venues
        self.mapRegions = neighborhoods.maptoMapRegionItems()
        self.genreOptions = genres
        self.vibeOptions = vibes
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
        var filters = [FilterParameter]()
        switch selectedGenre {
        case .all:
            break
        case let .one(genre):
            filters.append(FilterParameter(type: .genres, values: [genre.rawValue]))
        }
        switch selectedVibe {
        case .all:
            break
        case let .one(vibe):
            filters.append(FilterParameter(type: .vibes, values: [vibe.rawValue]))
        }
        
//        if selectedGenre{
//            filters.append(FilterParameter(type: .genres, values: [genre.rawValue]))
//        }
//        if let vibe = selectedVibe {
//            filters.append(FilterParameter(type: .vibes, values: [vibe.rawValue]))
//        }
        let (venueItems, neighborhoodItems, _, _) = venueLoader.retrieveFiltered(filters: filters)
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
