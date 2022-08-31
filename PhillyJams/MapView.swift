//
//  ContentView.swift
//  Shared
//
//  Created by Daveed Balcher on 7/18/22.
//

import SwiftUI
import MapKit
import MusicVenues

struct MapView: View {
    
    @StateObject var vm: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    ToggleView(options: vm.neighborhoods, optionToString: { $0.name }, selected: $vm.selectedNeighborhood)
                    
                    SelectorView(typeString: GenreType.description, options: vm.genreOptions, optionToString: { $0.rawValue }, selected: $vm.selectedGenres)
                    
                    SelectorView(typeString: VibeType.description, options: vm.vibeOptions, optionToString: { $0.rawValue }, selected: $vm.selectedVibes)
                    
                    Spacer()
                }
                .padding([.leading])
                
                ZStack(alignment: .bottom) {
                    
                    Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.venues) { venue in
                        MapAnnotation(coordinate: venue.coordinates.mapCoordinates) {
                            Button {
                                vm.selectedVenue = venue
                            } label: {
                                VenueMarker(venue: venue, isSelected: venue == vm.selectedVenue)
                            }
                        }
                    }
                    .animation(.default, value: vm.mapRegion)
                    .ignoresSafeArea()
                    .edgesIgnoringSafeArea(.all)
                    
                    if let venue = vm.selectedVenue {
                        NavigationLink {
                            VenueDetailView(venue: venue)
                        } label: {
                            VenueBottomView(venue: venue)
                        }
                    }
                }
            }
            .navigationTitle("Philly Jams")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    init(loader: VenueLoader) {
        _vm = StateObject(wrappedValue: ViewModel(venueLoader: loader))
    }
}

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        // Remove back button text
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(loader: DefaultVenueLoader())
    }
}
