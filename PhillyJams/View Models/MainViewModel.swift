//
//  MainViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 12/1/22.
//

import MusicVenues

// MainViewModel - Gets places from service
//               - Passes any selected filters with request
//               - Stores places
final class MainViewModel: ObservableObject {
    @Published var mapViewModel: MapViewModel
    @Published var filtersViewModel: FiltersViewModel
    
    @Published var filtersDescription: String = "Jams · Chill · Jazz"
    
    let loader: PlaceLoader!
    
    init(loader: PlaceLoader) {
        self.loader = loader
        
        mapViewModel = MapViewModel(places: [])
        filtersViewModel = FiltersViewModel(properties: [])
    }
    
    func fetchPlaces() {
        loader.load(with: filtersViewModel.properties) { [weak self] placeItems in
            self?.mapViewModel.places = placeItems
        }
    }
}
