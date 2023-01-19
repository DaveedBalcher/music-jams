//
//  MainView.swift
//  Shared
//
//  Created by Daveed Balcher on 7/18/22.
//

import SwiftUI
import MapKit
import MusicVenues

struct MainView: View {
    
    @ObservedObject var vm: MainViewModel
    
    private var selectedMKRegion: Binding<MKCoordinateRegion>
    
    private let regionLevelOnePickerTitle = "Neighborhoods"
    
    @State private var isPresentingInfo = false
    @State private var isPresentingRegionLevelOnePicker = false
    @State private var isPresentingFiltersPicker = false
    
    init(vm: MainViewModel) {
        _vm = ObservedObject(wrappedValue: vm)
        
        selectedMKRegion = Binding(get: { vm.selectedRegion.mkRegion },
                                   set: { newMKRegion in
                if let newValue = (vm.regions.first { $0.mkRegion == newMKRegion }) {
                    vm.selectedRegion = newValue
                }
            })
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                MapView(selectedMKRegion: vm.selectedRegion.mkRegion,
                        places: $vm.places,
                        selectedPlace: vm.selectedPlace) { selectedPlace in
                    vm.selectedPlace = selectedPlace
                }
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: 92)
                    .ignoresSafeArea()
                
                VStack {
//                    if !vm.mapViewModel.hasEvents {
//                        SimpleBannerView(message: "No events", backgroundColor: .red)
//                    }
                    
                    MapNavigatorView(selectedRegion: $vm.selectedRegion,
                                     isPresentingRegionLevelOnePicker: $isPresentingRegionLevelOnePicker)
                    .padding([.top], 8)
                    .padding([.leading, .trailing], 12)
                    
                    Spacer()
                    
                    if let place = vm.selectedPlace {
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
            RegionPicker(title: regionLevelOnePickerTitle,
                         regions: vm.regions,
                         selectedRegion: $vm.selectedRegion,
                         isShowing: $isPresentingRegionLevelOnePicker)
        }
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
