//
//  MainViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 12/1/22.
//

import Combine
import MusicVenues

// MainViewModel - Gets places from service
//               - Passes any selected filters with request
//               - Stores places
final class MainViewModel: ObservableObject {
    @Published var regions: [Region]
    @Published var selectedRegion: Region {
        didSet {
            updateFilteredPlaces()
        }
    }
    @Published var places: [Place]
    @Published var filteredPlaces: [Place]
    @Published var selectedPlace: Place?
    
    let loader: PlaceLoader!
    
    init(loader: PlaceLoader) {
        self.loader = loader
        
        regions = []
        selectedRegion = Region.defaultLevelTwo
        places = []
        filteredPlaces = []
    }
    
    func fetchPlaces() {
        loader.load() { [weak self] regions, places in
            self?.regions = regions
            self?.places = places
            self?.updateFilteredPlaces()
        }
    }
    
    func updateFilteredPlaces() {
        if selectedRegion == Region.defaultLevelTwo {
            filteredPlaces = places
        } else {
            filteredPlaces = places.filter { $0.regionLevelOne == selectedRegion }
        }
    }
}

extension Region {
    static var defaultLevelTwo: Region {
        Region(
            title: "Philadelphia",
            colorString: "006BB6",
            level: .two,
            latitude: 39.975,
            longitude: -75.175
        )
    }
}
