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
    @State var selectedMKRegion: MKCoordinateRegion = Region.defaultLevelTwo.mkRegion
    @Binding var places: [Place]
    var selectedPlace: Place?
    
    var didSelectPlace: ((Place) -> Void)?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: Binding(get: { self.selectedMKRegion},
                                          set: { _, _ in}),
                annotationItems: places) { place in
                MapAnnotation(coordinate: place.coordinate) {
                    PlaceMarker(vm: PlaceViewModel(place: place), isSelected: place == selectedPlace)
                    .onTapGesture {
                        didSelectPlace?(place)
                        print("Clicked on \(place.title)")
                    }
                }
            }
            .padding([.top], -8)
            .animation(.default, value: selectedMKRegion)
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {

        let place = Place.preview

        MapView(places: .constant([place]),
                selectedPlace: place) { _ in }
    }
}
