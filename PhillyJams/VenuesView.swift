//
//  ContentView.swift
//  Shared
//
//  Created by Daveed Balcher on 7/18/22.
//

import SwiftUI
import MapKit
import MusicVenues

class InfoViewModel: ObservableObject {
    @Published var isPresented = false
}

struct VenuesView: View {
    
    @StateObject var vm: ViewModel
    @StateObject var infoVM = InfoViewModel()
    
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
                
                MapView(venues: vm.venues,
                        mapRegion: $vm.mapRegion,
                        selectedVenue: $vm.selectedVenue
                )
            }
            .navigationBarTitleDisplayMode(.inline)
            .popover(isPresented: $infoVM.isPresented){
                InfoView()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("philly_jams_logo_navbar")
                }
                ToolbarItem {
                    Button {
                        infoVM.isPresented = true
                    } label: {
                        Label("Information", systemImage: "info.circle")
                    }
                }
            }
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

struct VenuesView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesView(loader: DefaultVenueLoader())
    }
}
