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
    @Published var filtersViewModel: FiltersViewModel
    
    var anyCancellable: [AnyCancellable] = []
    
    let loader: PlaceLoader!
    
    init(loader: PlaceLoader) {
        self.loader = loader
        
        filtersViewModel = FiltersViewModel(properties: [])
        
        mapViewModel = MapViewModel(places: [])
    }
    
    func fetchPlaces() {
        loader.load(with: filtersViewModel.properties) { [weak self] places in
            self?.mapViewModel.places = places
            self?.filtersViewModel = FiltersViewModel(places: places)
            
            
            self?.filtersViewModel.didPublish = { [weak self] in
                self?.objectWillChange.send()
            }
            
            self?.mapViewModel.didPublish = { [weak self] in
                self?.objectWillChange.send()
            }
        }
    }
    
    func updateAvailableFilters() {
        
    }
    
    func makeAllFiltersAvailable() {
        
    }
}
