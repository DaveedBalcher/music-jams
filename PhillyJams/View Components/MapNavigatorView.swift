//
//  NeighborhoodView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/12/22.
//

import SwiftUI
import MusicVenues

struct MapNavigatorView: View {
    @ObservedObject var vm: MapViewModel
    
    var filtersDescription: String = ""
    @Binding var isPresentingRegionLevelOnePicker: Bool
    @Binding var isPresentingFiltersPicker: Bool
    
    var body: some View {
        HStack {
            Button {
                if vm.isZoomedIn {
                    vm.zoomOutToLevelTwo()
                } else {
                    isPresentingRegionLevelOnePicker = true
                }
            } label: {
                Image(systemName: vm.isZoomedIn ? "chevron.left" : "map")
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 20, height: 17)
                    .padding([.trailing], 4)
                    .padding([.leading], 8)
                    .foregroundColor(vm.selectedRegion.color)
            }
            
            VStack(alignment: .leading) {
                Button {
                    if vm.isZoomedIn {
                        vm.zoomOutToLevelTwo()
                    } else {
                        isPresentingRegionLevelOnePicker = true
                    }
                } label: {
                    Text(vm.selectedRegion.title)
                        .foregroundColor(vm.selectedRegion.color)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                Text(filtersDescription)
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Button {
                isPresentingFiltersPicker = true
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .resizable()
                    .frame(width: 18, height: 12)
                    .padding(8)
                    .foregroundColor(.lightBlue)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.lightBlue, lineWidth: 2)
                    )
            }
            .padding([.trailing], 8)

        }
        .padding([.leading, .trailing], 8)
        .padding([.top, .bottom], 12)
        .frame(height: 62)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.white)
                RoundedRectangle(cornerRadius: 8).strokeBorder(Color.accentColor.opacity(0.25))
            }
                .shadow(color: Color.accentColor.opacity(0.25), radius: 8)
        )
        .padding([.top], 6)
    }
}

struct MapNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        
        let place = Place.preview
        
        HStack(alignment: .top) {
            MapNavigatorView(vm: MapViewModel(places: [place]),
                             filtersDescription: "Jams · Chill · Jazz",
                             isPresentingRegionLevelOnePicker: .constant(false),
                             isPresentingFiltersPicker: .constant(false)
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
}
