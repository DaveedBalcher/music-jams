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
    
    private let regionLevelOnePickerTitle = "Neighborhoods"
    
    @State private var isPresentingInfo = false
    @State private var isPresentingRegionLevelOnePicker = false
    @State private var isPresentingFiltersPicker = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                MapView(vm: vm.mapViewModel)
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: 92)
                    .ignoresSafeArea()
                
                VStack {
                    if !vm.mapViewModel.places.filter { !$0.events.isEmpty }.isEmpty { // Domain Detail
                        SimpleBannerView(message: "No events", backgroundColor: .red) // Domain Detail
                    }
                    
                    MapNavigatorView(vm: vm.mapViewModel,
                                     filtersDescription: $vm.filtersDescription,
                                     isPresentingRegionLevelOnePicker: $isPresentingRegionLevelOnePicker,
                                     isPresentingFiltersPicker: $isPresentingFiltersPicker
                    )
                    .padding([.top], 8)
                    .padding([.leading, .trailing], 12)
                    
                    Spacer()
                    
                    if let place = vm.mapViewModel.selectedPlace {
                        let placeVM = PlaceViewModel(place: place)
                        NavigationLink {
                            let eventsVMs = place.events.map { EventViewModel($0) }
                            PlaceDetailView(placeVM: placeVM, eventsVM: eventsVMs)
                        } label: {
                            PlacePreviewView(placeVM: placeVM)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("philly_jams_logo_navbar")
                        .padding([.leading], 12)
                        .padding([.trailing], 12)
                        .padding([.bottom], 4)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    InfoBannerView(isPresentingInfo: $isPresentingInfo)
                }
            }
        }
        .popover(isPresented: $isPresentingInfo){
            InfoView(isPresenting: $isPresentingInfo)
        }
        .popover(isPresented: $isPresentingRegionLevelOnePicker) {
//            RegionPicker(title: regionLevelOnePickerTitle,
//                         regions: $mapViewModel.filteredRegions,
//                         selectedRegion: $mapViewModel.currentRegion,
//                         isShowing: $isPresentingRegionLevelOnePicker)
        }
        .popover(isPresented: $isPresentingFiltersPicker) {
            //TODO: Check If filters are empty
//            MultipleSectionPicker(
//                vm: MultipleSectionViewModel(sections: SectionModel.mapFromFilters(filterOptions: vm.filterOptions, filterSelected: vm.filtersSelected)),
//                title: "Filters") { selectedFilters in
//                    vm.filtersSelected = selectedFilters
//                    isPresentingFiltersPicker = false
//                }
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

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: MainViewModel.init(loader: DefaultPlaceLoader()))
    }
}
