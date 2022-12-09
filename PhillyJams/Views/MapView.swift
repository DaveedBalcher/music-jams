//
//  MapView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/1/22.
//

import SwiftUI
import MapKit
import MusicVenues


struct MapView: View {
    @ObservedObject var vm: MapViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $vm.selectedMKRegion, annotationItems: vm.places) { place in
                MapAnnotation(coordinate: place.coordinate) {
                    Button {
                        vm.selectedPlace = place
                    } label: {
                        PlaceMarker(vm: PlaceViewModel(place: place), isSelected: place == vm.selectedPlace)
                    }
                }
            }
            .padding([.top], -8)
            .animation(.default, value: vm.selectedMKRegion)
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            vm.checkIfLocationServicesIsEnabled()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        
        let place = Place.preview
        
        MapView(vm: MapViewModel(places: [place]))
    }
}
