//
//  MapView-ViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/8/22.
//

import SwiftUI
import MapKit
import MusicVenues

extension MapView {
    
    @MainActor class ViewModel: ObservableObject {
        
        private var defaultCoordinates = CLLocationCoordinate2D(latitude: 39.9509, longitude: -75.1575)
        private var defaultSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        @Published var mapRegion: MKCoordinateRegion
        
        @Published var venues: [VenueItem] = []
        @Published var selectedVenue: VenueItem?
        
        @Published var neighborhoods: [NeighborhoodItem] = []
        @Published var selectedNeighborhood: NeighborhoodItem = NeighborhoodItem(name: "Philadelphia", center: Coordinates.defaultValue, color: nil) {
            didSet {
                selectFirstVenueForNeighborhood()
                setMapRegion()
            }
        }
        
        @Published var genres: [GenreType] = []
        @Published var selectedGenres = Set<GenreType>() {
            didSet {
                reloadVenues()
            }
        }
        
        @Published var vibes: [VibeType] = VibeType.allCases
        @Published var selectedVibes = Set<VibeType>() {
            didSet {
                reloadVenues()
            }
        }
        
        let venueLoader: VenueLoader!
        
        init(venueLoader: VenueLoader) {
            self.mapRegion = MKCoordinateRegion(center: defaultCoordinates, span: defaultSpan)
            
            self.venueLoader = venueLoader
            self.venueLoader.load()
            
            // Init Neighborhoods as non-empty
            self.neighborhoods = [selectedNeighborhood]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.retrieveVenues()
            }
        }
        
        func retrieveVenues() {
            let mapData = venueLoader.retrieve()
            setInitialState(with: mapData.venues, neighborhoods: mapData.neighborhoods)
        }
        
        func setInitialState(with venues: [VenueItem], neighborhoods: [NeighborhoodItem]) {
            
            self.neighborhoods = neighborhoods
            self.venues = venues
            self.selectedNeighborhood = self.neighborhoods[1]
            selectFirstVenueForNeighborhood()
            
            self.genres = venues.genres
        }
        
        func selectFirstVenueForNeighborhood() {
            self.selectedVenue = venues.first { selectedNeighborhood.name == $0.neighborhood?.name}
        }
        
        func setMapRegion() {
            self.mapRegion = MKCoordinateRegion(center: selectedNeighborhood.center.mapCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.02))
        }
        
        func reloadVenues() {
            var parameters = [FilterParameter]()
            if !selectedGenres.isEmpty {
                let genreParameter = FilterParameter(type: .genres, values: selectedGenres.rawValues)
                parameters.append(genreParameter)
            }
            if !selectedVibes.isEmpty {
                let vibeParameter = FilterParameter(type: .vibes, values: selectedVibes.rawValues)
                parameters.append(vibeParameter)
            }
            let (reloadedVenues, _) = venueLoader.retrieveFiltered(filters: parameters)
            venues = reloadedVenues
        }
    }
}

extension Coordinates {
    
    var mapCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension MKCoordinateRegion: Equatable {
    
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude == rhs.center.latitude &&
        lhs.center.longitude == rhs.center.longitude &&
        lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
        lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
}
