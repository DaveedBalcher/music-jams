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
    @State var isPresentingFiltersPicker = false
    
    var regionFiltersDescription: String {
        let strings = vm.filtersSelected.compactMap { $0.value }
        return strings.isEmpty ? "All Events ·  Vibes · Genres" : strings.joined(separator: " · ")
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                MapView(
                    venues: vm.filteredVenues,
                    mapRegion: $vm.mapRegion,
                    selectedVenue: $vm.selectedVenue
                )
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: 92)
                    .ignoresSafeArea()
                
                VStack {
                    MapRegionView(mapRegionTitle: vm.selectedMapRegion.name,
                                  mapRegionColor: vm.selectedMapRegion.color,
                                  regionFiltersDescription: regionFiltersDescription) {
                        isPresentingMapRegionPicker = true
                    } onTapSelectRegionFilters: {
                        isPresentingFiltersPicker = !vm.filterOptions.isEmpty
                    }
                    .padding([.leading, .trailing], 12)
                    
                    if vm.checkVenueAvailable() {
                        ZStack {
                            Color.red
                                .frame(height: 44)
                            
                            Text("No venues")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("philly_jams_logo_navbar")
                        .padding([.leading], 8)
                        .padding([.trailing], 8)
                }
                
                ToolbarItem {
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
                                .foregroundColor(.lightBlue)
                                .background(Circle().fill(.white.opacity(0.5)))
                        }
                    }
                    .offset(y: -8)
                }
            }
        }
        .popover(isPresented: $isPresentingInfo){
            InfoView()
        }
        .popover(isPresented: $isPresentingMapRegionPicker) {
            MapRegionPicker(title: "Neighborhoods",
                            mapRegions: vm.filteredMapRegions.map { $0.name },
                            selectedMapRegions: vm.selectedMapRegion.name) {
                selected in
                if let selected = selected {
                    vm.setMapRegion(name: selected)
                }
                isPresentingMapRegionPicker = false
            }
        }
        .popover(isPresented: $isPresentingFiltersPicker) {
            MultipleSectionPicker(
                vm: MultipleSectionViewModel(sections: SectionModel.mapFromFilters(filterOptions: vm.filterOptions, filterSelected: vm.filtersSelected)),
                title: "Filters") { selectedFilters in
                    vm.filtersSelected = selectedFilters
                    isPresentingFiltersPicker = false
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
