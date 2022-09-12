//
//  ContentView.swift
//  Shared
//
//  Created by Daveed Balcher on 7/18/22.
//

import SwiftUI
import MapKit
import MusicVenues

struct VenuesView: View {
    
    @ObservedObject var vm: VenuesViewModel
    @State var isPresentedInfo = false
    
    @State var mapRegionTitle: String = "Philadelphia"
    @State var regionFiltersDescription: String = "Jams · Vibes · Genres"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Button {
                    isPresentedInfo = true
                } label: {
                    Label {
                        Text("About")
                            .font(.caption)
                            .fontWeight(.light)
                            .offset(x: -4)
                    } icon: {
                        Image(systemName: "info.circle")
                    }

                }
                .padding([.leading], 48)
                .offset(y: -2)
                
                MapView(
                    venues: vm.venues,
                    mapRegion: $vm.mapRegion,
                    selectedVenue: $vm.selectedVenue
                )
            }
            .navigationBarTitleDisplayMode(.inline)
            .popover(isPresented: $isPresentedInfo){
                InfoView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("philly_jams_logo_navbar")
                        .padding([.bottom], 8)
                        .padding([.leading], 8)
                }
                ToolbarItem {
                    MapRegionView(mapRegionTitle: mapRegionTitle, regionFiltersDescription: regionFiltersDescription) {
                        
                    } onTapSelectRegionFilters: {
                        
                    }
                }
            }
        }
    }
    
    init(vm: VenuesViewModel) {
        _vm = ObservedObject(wrappedValue: vm)
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        // Remove back button text
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

struct VenuesView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesView(vm: VenuesViewModel.init(initialMapRegion: MapRegionItem.initialState, venueLoader: DefaultVenueLoader()))
    }
}
