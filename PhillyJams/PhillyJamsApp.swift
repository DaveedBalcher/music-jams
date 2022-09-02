//
//  PhillyJamsApp.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import SwiftUI
import MusicVenues

class MainFlow {
    init(vm: VenuesViewModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            vm.retrieveVenuesData()
            vm.setNeighborhood(name: "Fishtown")
        }
    }
}

private let venuesViewModel = VenuesViewModel(initialMapRegion: MapRegionItem.initialState, venueLoader: DefaultVenueLoader())

@main
struct PhillyJamsApp: App {
    
    let mainFlow = MainFlow(vm: venuesViewModel)
    
    var body: some Scene {
        WindowGroup {
            VenuesView(vm: venuesViewModel)
        }
    }
}
