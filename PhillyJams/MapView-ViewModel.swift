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
        
        private var defaultNeighborhoodName = "Fishtown"
        @Published var neighborhoods: [NeighborhoodItem] = []
        @Published var selectedNeighborhood: NeighborhoodItem = NeighborhoodItem(name: "Philadelphia", center: Coordinates.defaultValue, color: nil) {
            didSet {
                setInitialVenueForInitialNeighborhood()
                setMapRegion()
            }
        }
        
        private var parameters = [FilterParameter]()
        @Published var genreOptions: [GenreType] = []
//        @Published var activeGenres: [GenreType] = []
        @Published var selectedGenres = Set<GenreType>() {
            didSet {
                filterGenres()
            }
        }

        @Published var vibeOptions: [VibeType] = VibeType.allCases
//        @Published var activeVibes: [VibeType] = VibeType.allCases
        @Published var selectedVibes = Set<VibeType>() {
            didSet {
                filterVibes()
            }
        }

        let venueLoader: VenueLoader!
        
        init(venueLoader: VenueLoader) {
            self.mapRegion = MKCoordinateRegion(center: defaultCoordinates, span: defaultSpan)
            
            self.venueLoader = venueLoader
            
            // Init Neighborhoods as non-empty
            self.neighborhoods = [selectedNeighborhood]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.retrieveVenues()
            }
        }
        
        func retrieveVenues() {
            let (venues, neighborhoods, genres, vibes) = venueLoader.retrieveFiltered(filters: [])
            
            self.venues = venues
            self.neighborhoods = neighborhoods
            self.genreOptions = genres
            self.vibeOptions = vibes
            
            setInitialNeighborhood()
            setInitialVenueForInitialNeighborhood()
        }

        func setInitialNeighborhood() {
            self.selectedNeighborhood = self.neighborhoods.first { $0.name == defaultNeighborhoodName } ?? self.neighborhoods.first!
        }
        
        func setInitialVenueForInitialNeighborhood() {
            self.selectedVenue = venues.first { selectedNeighborhood.name == $0.neighborhood?.name}
        }
        
        func setMapRegion() {
            self.mapRegion = MKCoordinateRegion(center: selectedNeighborhood.center.mapCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.02))
        }
        
        func filterGenres() {
            let genreParameter = FilterParameter(type: .genres, values: selectedGenres.rawValues)
            parameters.append(genreParameter)

            let (venues, neighborhoods, genres, vibes) = venueLoader.retrieveFiltered(filters: [])

            self.venues = venues
            self.neighborhoods = neighborhoods
            self.genreOptions = genres
            self.vibeOptions = vibes

            setInitialNeighborhood()
            setInitialVenueForInitialNeighborhood()
        }

        func filterVibes() {
            let vibeParameter = FilterParameter(type: .vibes, values: selectedVibes.rawValues)
            parameters.append(vibeParameter)

            let (reloadedVenues, _, _, _) = venueLoader.retrieveFiltered(filters: parameters)
            venues = reloadedVenues
            self.genreOptions = genreOptions
            self.vibeOptions = vibeOptions

            self.neighborhoods = venues.neighborhoods
            setInitialVenueForInitialNeighborhood()
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
