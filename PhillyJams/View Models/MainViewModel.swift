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
    
    private var cancellables = [AnyCancellable]()
    private var sink1: AnyPublisher<Place?, Never>?
    private var sink2: AnyPublisher<[String : [String]], Never>?
    
    let loader: PlaceLoader!
    
    init(loader: PlaceLoader) {
        self.loader = loader
        
        filtersViewModel = FiltersViewModel(properties: [])
        
        mapViewModel = MapViewModel(places: [])
        
        sink1 = mapViewModel.$selectedPlace.eraseToAnyPublisher()
        sink2 = filtersViewModel.$selectedProperties.eraseToAnyPublisher()
    }
    
    func processSink1() {
        sink1?
            .sink(receiveValue: { value in
                self.objectWillChange.send()
            })
            .store(in: &cancellables)
    }

    func processSink2() {
        sink2?
            .sink(receiveValue: { value in
                self.objectWillChange.send()
            })
            .store(in: &cancellables)
    }
    
    func fetchPlaces() {
        loader.load(with: filtersViewModel.properties) { [weak self] places in
            self?.mapViewModel.places = places
            self?.filtersViewModel = FiltersViewModel(places: places)
            
            self?.processSink1()
            self?.processSink2()
            
//            self?.filtersViewModel.didPublish = { [weak self] in
//                self?.fetchPlaces()
////                self?.objectWillChange.send()
//            }
//
//            self?.mapViewModel.didPublish = { [weak self] in
//                self?.objectWillChange.send()
//            }
        }
    }
    
    func updateAvailableFilters() {
        
    }
    
    func makeAllFiltersAvailable() {
        
    }
}
