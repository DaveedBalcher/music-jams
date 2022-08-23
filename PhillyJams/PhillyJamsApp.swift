//
//  PhillyJamsApp.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import SwiftUI
import MusicVenues

@main
struct PhillyJamsApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(loader: DefaultVenueLoader())
        }
    }
}
