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
    
//    @State var mapRegions: [String] = ["A", "B", "C", "D"]
//    @State var selectedMapRegion: String = "A"
    var mapRegionTitle: String {
        vm.selectedMapRegion.name
    }
    @State var regionFiltersDescription: String = "Jams · Vibes · Genres"
    
    var body: some View {
        VStack{
            HStack {
                Image("philly_jams_logo_navbar")
                    .padding([.leading], 8)
                    .padding([.trailing], 8)
                
                Spacer()
                
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
                .offset(y: -8)
            }
            .padding([.leading, .trailing], 12)
            
            MapRegionView(mapRegionTitle: mapRegionTitle, regionFiltersDescription: regionFiltersDescription) {
                isPresentingMapRegionPicker = true
            } onTapSelectRegionFilters: {
                
            }
            .padding([.leading, .trailing], 12)
            .offset(y: 4)
            
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
            MapRegionPicker(title: "Neighborhoods",
                            mapRegions: vm.mapRegions.map { $0.name },
                            selectedMapRegions: vm.selectedMapRegion.name,
                            showView: $isPresentingMapRegionPicker) {
                selected in
                if let mapRegion = (vm.mapRegions.first { $0.name == selected }) {
                    vm.selectedMapRegion = mapRegion
                }
            }
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
