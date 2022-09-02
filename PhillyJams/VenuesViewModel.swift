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
    
    @Published var neighborhoods: [NeighborhoodItem] = []
    @Published var selectedNeighborhood: NeighborhoodItem {
        didSet {
            setInitialVenue()
            setMapRegion()
        }
    }
    
    private var parameters = [FilterParameter]()
    @Published var genreOptions: [GenreType] = []
    @Published var selectedGenres = Set<GenreType>() {
        didSet {
            filterVenues()
        }
    }
    
    @Published var vibeOptions: [VibeType] = VibeType.allCases
    @Published var selectedVibes = Set<VibeType>() {
        didSet {
            filterVenues()
        }
    }
    
    let venueLoader: VenueLoader!
    
    init(venueLoader: VenueLoader) {
        
        let initialModel = NeighborhoodMapItem.initialState
        
        self.mapRegion = MKCoordinateRegion(center: initialModel.center, span: initialModel.span)

        self.venueLoader = venueLoader
        _selectedNeighborhood = Published(initialValue:  initialModel.item)
        // Init Neighborhoods as non-empty
        self.neighborhoods = [selectedNeighborhood]
    }
    
    func retrieveVenuesData() {
        let (venues, neighborhoods, genres, vibes) = venueLoader.retrieveFiltered()
        self.venues = venues
        self.neighborhoods = neighborhoods
        self.genreOptions = genres
        self.vibeOptions = vibes
    }
    
    func setNeighborhood(name: String? = nil) {
        if let neighborhood = neighborhoods.first(where: { $0.name == name }) ?? neighborhoods.first {
            selectedNeighborhood = neighborhood
        }
        setInitialVenue()
    }
    
    func setInitialVenue() {
        selectedVenue = venues.first { selectedNeighborhood.name == $0.neighborhood?.name}
    }
    
    func setMapRegion() {
        mapRegion = MKCoordinateRegion(center: selectedNeighborhood.center.mapCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.02))
    }
    
    func filterVenues() {
        let genreParameter = FilterParameter(type: .genres, values: selectedGenres.rawValues)
        let vibeParameter = FilterParameter(type: .vibes, values: selectedVibes.rawValues)
        (venues, neighborhoods, _, _) = venueLoader.retrieveFiltered(filters: [genreParameter, vibeParameter])
        venues = venues
        neighborhoods = neighborhoods
        setNeighborhood(name: selectedNeighborhood.name)
    }
}

extension Coordinates {
    
    var mapCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
