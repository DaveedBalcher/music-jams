//
//  NeighborhoodView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/12/22.
//

import SwiftUI

struct MapRegionView: View {
    let mapRegionTitle: String
    let mapRegionColor: Color?
    let regionFiltersDescription: String
    let isZoomedOut: Bool
    
    let onTapSelectMapRegion: ()->()
    let onTapSelectZoomoutMapRegion: ()->()
    let onTapSelectRegionFilters: ()->()
    
    var body: some View {
        HStack {
            Button {
                isZoomedOut ? onTapSelectMapRegion() : onTapSelectZoomoutMapRegion()
            } label: {
                Image(systemName: isZoomedOut ? "map" : "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 20, height: 17)
                    .padding([.trailing], 4)
                    .padding([.leading], 8)
                    .foregroundColor(mapRegionColor ?? Color.accentColor)
            }
            
            VStack(alignment: .leading) {
                Button {
                    isZoomedOut ? onTapSelectMapRegion() : onTapSelectZoomoutMapRegion()
                } label: {
                    Text(mapRegionTitle)
                        .foregroundColor(mapRegionColor ?? Color.accentColor)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                Text(regionFiltersDescription)
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Button {
                onTapSelectRegionFilters()
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

struct MapRegionView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            MapRegionView(mapRegionTitle: "Philadelphia",
                          mapRegionColor: nil,
                          regionFiltersDescription: "Jams · Chill · Jazz",
                          isZoomedOut: true) {}
                onTapSelectZoomoutMapRegion: {}
                onTapSelectRegionFilters: {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
}
