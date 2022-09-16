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
        return strings.isEmpty ? "Jams · Vibes · Genres" : strings.joined(separator: " · ")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                MapRegionView(mapRegionTitle: vm.selectedMapRegion.name, regionFiltersDescription: regionFiltersDescription) {
                    isPresentingMapRegionPicker = true
                } onTapSelectRegionFilters: {
                    isPresentingFiltersPicker = true
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
                
                MapView(
                    venues: vm.filteredVenues,
                    mapRegion: $vm.mapRegion,
                    selectedVenue: $vm.selectedVenue
                )
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
                if let mapRegion = (vm.filteredMapRegions.first { $0.name == selected }) {
                    vm.selectedMapRegion = mapRegion
                }
                isPresentingMapRegionPicker = false
            }
        }
        .popover(isPresented: $isPresentingFiltersPicker) {
            let sections = vm.filterOptions.map { filter in
                SectionModel(type: filter.key,
                             displayIndex: [VibeType.description, GenreType.description].firstIndex(of: filter.key) ?? 0,
                             options: filter.value.filter { $0 != VibeType.defaultValue.rawValue},
                             selectedOption: vm.filtersSelected[filter.key] ?? nil
                )
            }
                .sorted()
            MultipleSectionPicker(
                vm: MultipleSectionViewModel(sections: sections),
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
