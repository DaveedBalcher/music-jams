//
//  PhillyJamsApp.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import SwiftUI
import MusicVenues

class MainFlow {
    init(vm: MainViewModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            vm.retrieveVenuesData()
        }
    }
}

private let mainViewModel = MainViewModel(venueLoader: DefaultVenueLoader())

@main
struct PhillyJamsApp: App {
    
    let mainFlow = MainFlow(vm: mainViewModel)
    
    var body: some Scene {
        WindowGroup {
            MainView(vm: mainViewModel)
        }
    }
}
