//
//  PhillyJamsApp.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import SwiftUI
import MusicVenues
import Firebase

class MainFlow {
    init(vm: MainViewModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            vm.fetchPlaces()
        }
    }
}

private let mainViewModel = MainViewModel(loader: RemotePlaceLoader())

@main
struct PhillyJamsApp: App {
//    init() {
//        FirebaseApp.configure()
//    }
    
    let mainFlow = MainFlow(vm: mainViewModel)
    
    var body: some Scene {
        WindowGroup {
            ContainerView(vm: mainViewModel)
        }
    }
}
