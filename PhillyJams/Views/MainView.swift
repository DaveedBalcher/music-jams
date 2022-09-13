//
//  ContentView.swift
//  Shared
//
//  Created by Daveed Balcher on 7/18/22.
//

import SwiftUI
import MapKit
import MusicVenues

struct MainView: View {
    
    @ObservedObject var vm: MainViewModel
    @State var isPresentingInfo = false
    @State var isPresentingMapRegionPicker = false
    
    @State var mapRegions: [String] = ["A", "B", "C", "D"]
    @State var selectedMapRegions: String = "A"
    var mapRegionTitle: String {
        selectedMapRegions
    }
    @State var regionFiltersDescription: String = "Jams · Vibes · Genres"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("philly_jams_logo_navbar")
                    .padding([.leading], 8)
                    .padding([.trailing], 8)
                    .padding([.bottom], 8)
                
                MapRegionView(mapRegionTitle: mapRegionTitle, regionFiltersDescription: regionFiltersDescription) {
                    isPresentingMapRegionPicker = true
                } onTapSelectRegionFilters: {
                    
                }
            }
            .padding([.leading, .trailing], 8)
            
            Button {
                isPresentingInfo = true
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
            .padding([.leading], 12)
            .offset(y: -8)
            
            MapView(
                venues: vm.venues,
                mapRegion: $vm.mapRegion,
                selectedVenue: $vm.selectedVenue
            )
        }
        .popover(isPresented: $isPresentingInfo){
            InfoView()
        }
        .popover(isPresented: $isPresentingMapRegionPicker) {
            MapRegionPicker(mapRegions: mapRegions,
                            selectedMapRegions: $selectedMapRegions,
                            showView: $isPresentingMapRegionPicker)
        }
    }
    
    init(vm: MainViewModel) {
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
        MainView(vm: MainViewModel.init(initialMapRegion: MapRegionItem.initialState, venueLoader: DefaultVenueLoader()))
    }
}
