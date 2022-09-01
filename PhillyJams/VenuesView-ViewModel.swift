//
//  VenuesView-ViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/8/22.
//

import SwiftUI
import MapKit
import MusicVenues

extension VenuesView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion: MKCoordinateRegion
        
        @Published var venues: [VenueItem] = []
        @Published var selectedVenue: VenueItem?
        
        @Published var neighborhoods: [NeighborhoodItem] = []
        @Published var selectedNeighborhood: NeighborhoodItem = NeighborhoodItem(name: "Philadelphia", center: Coordinates.defaultValue, color: nil) {
            didSet {
                setInitialVenueForInitialNeighborhood()
                setMapRegion()
            }
        }
        
        private var parameters = [FilterParameter]()
        @Published var genreOptions: [GenreType] = []
        @Published var selectedGenres = Set<GenreType>() {
            didSet {
                let genreParameter = FilterParameter(type: .genres, values: selectedGenres.rawValues)
                filterVenues(with: genreParameter)
            }
        }

        @Published var vibeOptions: [VibeType] = VibeType.allCases
        @Published var selectedVibes = Set<VibeType>() {
            didSet {
                let vibeParameter = FilterParameter(type: .vibes, values: selectedVibes.rawValues)
                filterVenues(with: vibeParameter)
            }
        }

        let venueLoader: VenueLoader!
        
        init(venueLoader: VenueLoader) {
            
            let initialModel = NeighborhoodMapModel.initialState
            
            self.mapRegion = MKCoordinateRegion(center: initialModel.center, span: initialModel.span)
            
            self.venueLoader = venueLoader
            
            // Init Neighborhoods as non-empty
            self.neighborhoods = [selectedNeighborhood]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.retrieveVenuesData()
            }
        }
        
        func retrieveVenuesData() {
            let (venues, neighborhoods, genres, vibes) = venueLoader.retrieveFiltered()
            
            self.venues = venues
            self.neighborhoods = neighborhoods
            self.genreOptions = genres
            self.vibeOptions = vibes
            
            setNeighborhood()
            setInitialVenueForInitialNeighborhood()
        }

        func setNeighborhood(name: String = "Fishtown") {
            self.selectedNeighborhood = self.neighborhoods.first { $0.name == name } ?? self.neighborhoods.first!
        }
        
        func setInitialVenueForInitialNeighborhood() {
            self.selectedVenue = venues.first { selectedNeighborhood.name == $0.neighborhood?.name}
        }
        
        func setMapRegion() {
            self.mapRegion = MKCoordinateRegion(center: selectedNeighborhood.center.mapCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.02))
        }
        
        func filterVenues(with filter: FilterParameter) {
            (venues, neighborhoods, _, _) = venueLoader.retrieveFiltered(filters: [filter])
            self.venues = venues
            self.neighborhoods = neighborhoods
            
            if !neighborhoods.contains(selectedNeighborhood) {
                setNeighborhood()
                setInitialVenueForInitialNeighborhood()
            }
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
