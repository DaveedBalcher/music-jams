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
    @Published var mapViewModel: MapViewModel
    
    let loader: PlaceLoader!
    
    init(loader: PlaceLoader) {
        self.loader = loader
        
        mapViewModel = MapViewModel(places: [])
    }
    
    func fetchPlaces() {
        loader.load() { [weak self] regions, places in
            self?.mapViewModel.places = places
        }
    }
}
