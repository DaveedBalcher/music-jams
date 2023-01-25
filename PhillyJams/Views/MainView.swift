//
//  MainView.swift
//  Shared
//
//  Created by Daveed Balcher on 7/18/22.
//

import SwiftUI
import MusicVenues

struct MainView: View {
    @Binding var regions: [Region]
    @Binding var selectedRegion: Region
    @Binding var places: [Place]
    @Binding var selectedPlace: Place?
    @State private var isPresentingRegionLevelOnePicker = false
    
    private let regionLevelOnePickerTitle = "Neighborhoods"
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MapView(selectedRegion: $selectedRegion,
                    places: $places,
                    selectedPlace: selectedPlace) { selectedPlace in
                self.selectedPlace = selectedPlace
            }
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(maxHeight: 92)
                .ignoresSafeArea()
            
            VStack {
                //                    if !vm.mapViewModel.hasEvents {
                //                        SimpleBannerView(message: "No events", backgroundColor: .red)
                //                    }
                
                MapNavigatorView(selectedRegion: $selectedRegion,
                                 isPresentingRegionLevelOnePicker: $isPresentingRegionLevelOnePicker)
                .padding([.top], 8)
                .padding([.leading, .trailing], 12)
                
                Spacer()
                
                if let place = selectedPlace {
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
        .popover(isPresented: $isPresentingRegionLevelOnePicker) {
            RegionPicker(title: regionLevelOnePickerTitle,
                         regions: regions,
                         selectedRegion: $selectedRegion,
                         isShowing: $isPresentingRegionLevelOnePicker)
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(regions: .constant([Region.preview]), selectedRegion: .constant(Region.preview), places: .constant([Place.preview]), selectedPlace: .constant(Place.preview))
    }
}
