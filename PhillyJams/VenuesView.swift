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
    
    var body: some View {
        NavigationView {
            VStack {
                FiltersToolbarView(
                    neighborhoods: vm.neighborhoods,
                    genreOptions: vm.genreOptions,
                    vibeOptions: vm.vibeOptions,
                    selectedNeighborhood: $vm.selectedNeighborhood,
                    selectedGenres: $vm.selectedGenres,
                    selectedVibes: $vm.selectedVibes)
                
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
        VenuesView(vm: VenuesViewModel.init(venueLoader: DefaultVenueLoader()))
    }
}
