//
//  NeighborhoodView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/12/22.
//

import SwiftUI
import MusicVenues

struct MapNavigatorView: View {
    @Binding var selectedRegion: Region
    @Binding var isPresentingRegionLevelOnePicker: Bool
    
    var isZoomedIn: Bool {
        selectedRegion.level == .one
    }
    
    func zoomOutToLevelTwo() {
        selectedRegion = Region.defaultLevelTwo
    }
    
    var body: some View {
        HStack {
            Button {
                if isZoomedIn {
                    zoomOutToLevelTwo()
                } else {
                    isPresentingRegionLevelOnePicker = true
                }
            } label: {
                Image(systemName: isZoomedIn ? "chevron.left" : "map")
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 20, height: 17)
                    .padding([.trailing], 4)
                    .padding([.leading], 8)
                    .foregroundColor(selectedRegion.color)
            }
            
            VStack(alignment: .leading) {
                Button {
                    if isZoomedIn {
                        zoomOutToLevelTwo()
                    } else {
                        isPresentingRegionLevelOnePicker = true
                    }
                } label: {
                    Text(selectedRegion.title)
                        .foregroundColor(selectedRegion.color)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            
            Spacer()
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
        
        HStack(alignment: .top) {
            MapNavigatorView(selectedRegion: .constant(Region.defaultLevelTwo),
                             isPresentingRegionLevelOnePicker: .constant(false)
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
}
