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
    
    @State var showPicker: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                MapView(
                    venues: vm.venues,
                    mapRegion: $vm.mapRegion,
                    selectedVenue: $vm.selectedVenue
                )
                .padding([.top], 42)
                
                FiltersToolbarView(
                    mapRegionOptions: vm.mapRegions,
                    genreOptions: vm.genreOptions,
                    vibeOptions: vm.vibeOptions,
                    selectedMapRegion: $vm.selectedMapRegion,
                    selectedGenres: $vm.selectedGenres,
                    selectedVibes: $vm.selectedVibes
                )
                
            }
//            .toolBarPopover(show: $showPicker) {
//                DatePicker("", selection: .constant(Date()))
//                    .datePickerStyle(.compact)
//                    .labelsHidden()
//            }
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
                    Button {
                        isPresentedInfo = true
                    } label: {
                        Label("Information", systemImage: "info.circle")
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
